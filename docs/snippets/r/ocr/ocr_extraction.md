```r title="R"
library(kreuzberg)

# Configure Tesseract OCR
ocr <- ocr_config(backend = "tesseract", language = "eng", dpi = 300L)
config <- extraction_config(force_ocr = TRUE, ocr = ocr)

# Extract text from a scanned image
result <- extract_file_sync("scan.png", config = config)

cat(sprintf("Extracted %d characters\n", nchar(result$content)))
cat(sprintf("Quality score: %s\n", result$quality_score))
cat("Content preview:\n")
cat(substr(result$content, 1, 200))
```
