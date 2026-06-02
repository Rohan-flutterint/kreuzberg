//! CORD (Receipt OCR) dataset loader.

use super::{DatasetError, Result, Split, StructuredFixture};
use serde_json::{json, Value};
use std::fs;
use std::path::Path;

/// Load CORD dataset fixtures from the given root directory.
///
/// The CORD dataset contains receipt documents with OCR ground truth.
/// Fixtures are organized by split (train/val/test).
///
/// # Arguments
///
/// * `root` - Root directory containing the CORD dataset
/// * `split` - Dataset split to load
///
/// # Returns
///
/// A vector of [`StructuredFixture`] items for the requested split.
pub fn load(root: &Path, split: Split) -> Result<Vec<StructuredFixture>> {
    let split_name = match split {
        Split::Train => "train",
        Split::Val => "val",
        Split::Test => "test",
    };

    let dataset_root = root.join("CORD").join(split_name);
    if !dataset_root.exists() {
        return Err(DatasetError::NotFound(dataset_root.display().to_string()));
    }

    let manifest_path = root.join("manifests").join("cord.toml");
    let manifest_content = fs::read_to_string(&manifest_path)
        .map_err(|e| DatasetError::Other(format!("Failed to read CORD manifest: {}", e)))?;

    let schema = load_cord_schema()?;
    let mut fixtures = Vec::new();

    // Parse manifest for (document, gt_json) pairs
    for line in manifest_content.lines() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('#') {
            continue;
        }

        let parts: Vec<&str> = line.split(',').map(|s| s.trim()).collect();
        if parts.len() < 2 {
            continue;
        }

        let doc_file = parts[0];
        let gt_file = parts[1];

        let doc_path = dataset_root.join(doc_file);
        let gt_path = dataset_root.join(gt_file);

        if !doc_path.exists() || !gt_path.exists() {
            continue;
        }

        let gt_json: Value = serde_json::from_str(&fs::read_to_string(&gt_path)?)?;

        fixtures.push(StructuredFixture {
            document_path: doc_path,
            schema: schema.clone(),
            ground_truth: gt_json,
            dataset: "cord",
            split,
        });
    }

    Ok(fixtures)
}

/// Load the CORD JSON schema.
fn load_cord_schema() -> Result<Value> {
    // CORD schema derived from receipt field set: company, date, address, total, items, etc.
    Ok(json!({
        "$schema": "http://json-schema.org/draft-07/schema#",
        "type": "object",
        "properties": {
            "company": { "type": ["string", "null"] },
            "date": { "type": ["string", "null"] },
            "address": { "type": ["string", "null"] },
            "total": { "type": ["number", "null"] },
            "items": {
                "type": ["array", "null"],
                "items": {
                    "type": "object",
                    "properties": {
                        "name": { "type": "string" },
                        "quantity": { "type": "number" },
                        "price": { "type": "number" }
                    }
                }
            }
        }
    }))
}
