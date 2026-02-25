```r title="R"
library(kreuzberg)

# Extract a file synchronously
result <- extract_file_sync("path/to/document.pdf")

# Access extraction results
cat("Content length:", nchar(result$content), "\n")
cat("Mime type:", result$mime_type, "\n")
cat("Pages:", page_count(result), "\n")
cat("Quality score:", result$quality_score, "\n")
```
