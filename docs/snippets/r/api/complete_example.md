```r title="R"
library(kreuzberg)

# Create extraction config with OCR and chunking
config <- extraction_config(
  force_ocr = TRUE,
  ocr = ocr_config(backend = "tesseract", language = "eng", dpi = 300L),
  chunking = chunking_config(max_characters = 500L, overlap = 100L),
  output_format = "markdown"
)

# Extract file with config
result <- extract_file_sync("document.pdf", config = config)

# Inspect all result fields
cat("Content length:", nchar(result$content), "\n")
cat("MIME type:", result$mime_type, "\n")
cat("Pages:", page_count(result), "\n")
cat("Tables:", length(result$tables), "\n")
cat("Chunks:", length(result$chunks), "\n")
cat("Images:", length(result$images), "\n")
cat("Elements:", length(result$elements), "\n")
cat("Detected language:", result$detected_language, "\n")
cat("Quality score:", result$quality_score, "\n")
```
