```r title="R"
library(kreuzberg)

file_path <- "document.pdf"

config <- extraction_config(
  output_format = "markdown"
)

result <- extract_file_sync(file_path, config = config)

cat(sprintf("MIME type: %s\n", result$mime_type))
cat(sprintf("Content length: %d characters\n", nchar(result$content)))
cat("Content preview:\n")
cat(substr(result$content, 1, 200))
```
