```r title="R"
library(kreuzberg)

# Read file as binary data
file_data <- readBin("path/to/document.pdf", what = "raw", n = file.size("path/to/document.pdf"))

# Extract from bytes with explicit mime type
result <- extract_bytes_sync(file_data, mime_type = "application/pdf")

# Access extraction results
cat("Content preview:", substr(result$content, 1, 100), "\n")
cat("Mime type:", result$mime_type, "\n")
cat("Pages:", page_count(result), "\n")
```
