```r title="R"
library(kreuzberg)

ocr <- ocr_config(
  backend = "tesseract",
  language = "eng",
  dpi = 300L
)

chunking <- chunking_config(
  max_characters = 2000L,
  overlap = 300L
)

config <- extraction_config(
  force_ocr = TRUE,
  ocr = ocr,
  chunking = chunking,
  output_format = "markdown"
)

file_path <- "document.pdf"
result <- extract_file_sync(file_path, config = config)
cat(sprintf("MIME type: %s\n", result$mime_type))
```
