//! Dataset loaders for structured extraction benchmarking.
//!
//! This module provides loaders for public document extraction datasets:
//! - **CORD**: Receipt OCR dataset
//! - **SROIE**: Scanned Receipts OCR and Information Extraction (ICDAR 2019)
//! - **FUNSD**: Form Understanding in Noisy Scanned Documents
//! - **DocILE**: Document Intelligence Lab Evaluation (invoices)
//! - **VRDU**: Visually Rich Document Understanding
//!
//! Each dataset loader returns a list of [`StructuredFixture`] items, containing
//! document paths, ground truth JSON, schemas, and split information.

use serde_json::Value;
use std::path::PathBuf;
use thiserror::Error;

pub mod cord;
pub mod docile;
pub mod funsd;
pub mod sroie;
pub mod vrdu;

/// Dataset split (train/validation/test).
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Split {
    Train,
    Val,
    Test,
}

/// A single structured extraction fixture from a public dataset.
#[derive(Debug, Clone)]
pub struct StructuredFixture {
    /// Path to the document file (PDF, image, etc.)
    pub document_path: PathBuf,

    /// JSON Schema (draft-07) for validation.
    /// May be dataset-canonical or derived from ground truth.
    pub schema: Value,

    /// Ground truth extraction as JSON.
    pub ground_truth: Value,

    /// Dataset identifier ("cord", "sroie", "funsd", "docile", "vrdu").
    pub dataset: &'static str,

    /// Train / validation / test split.
    pub split: Split,
}

/// Error type for dataset loading operations.
#[derive(Debug, Error)]
pub enum DatasetError {
    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),

    #[error("JSON parsing error: {0}")]
    Json(#[from] serde_json::Error),

    #[error("Dataset not found at {0}")]
    NotFound(String),

    #[error("Invalid split: {0}")]
    InvalidSplit(String),

    #[error("Dataset error: {0}")]
    Other(String),
}

pub type Result<T> = std::result::Result<T, DatasetError>;

/// Load CORD (Receipt OCR) dataset fixtures.
pub use cord::load as load_cord;

/// Load SROIE (ICDAR 2019 Receipts) dataset fixtures.
pub use sroie::load as load_sroie;

/// Load FUNSD (Forms) dataset fixtures.
pub use funsd::load as load_funsd;

/// Load DocILE (Invoices) dataset fixtures.
pub use docile::load as load_docile;

/// Load VRDU (Visually Rich Documents) dataset fixtures.
pub use vrdu::load as load_vrdu;
