```r title="R"
library(kreuzberg)

# Configure OCR settings
ocr <- ocr_config(backend = "tesseract", language = "eng", dpi = 300L)
config <- extraction_config(force_ocr = TRUE, ocr = ocr)

# Extract an image file with OCR enabled
result <- extract_file_sync("image.png", config = config)

# Print OCR results
cat(sprintf("Extracted text from image:\n"))
cat(content(result))
cat(sprintf("\n\nDetected language: %s\n", detected_language(result)))
```
