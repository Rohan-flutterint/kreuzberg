```r title="R"
library(kreuzberg)

# Configure multi-language OCR (English, French, German)
ocr <- ocr_config(backend = "tesseract", language = "eng+fra+deu")
config <- extraction_config(force_ocr = TRUE, ocr = ocr)

# Extract from a multilingual document
result <- extract_file_sync("multilingual.png", config = config)

cat(sprintf("Detected language: %s\n", detected_language(result)))
cat(sprintf("Extracted %d characters\n", nchar(result$content)))
cat("Content preview:\n")
cat(substr(result$content, 1, 200))
```
