```r title="R"
library(kreuzberg)

# Read file as binary data
file_data <- readBin("path/to/document.docx", what = "raw", n = file.size("path/to/document.docx"))

# Note: extract_bytes() blocks in R despite being async
result <- extract_bytes(file_data, mime_type = "application/vnd.openxmlformats-officedocument.wordprocessingml.document")

# Access extraction results
cat("Elements extracted:", length(result$elements), "\n")
cat("Detected language:", result$detected_language, "\n")
cat("Quality score:", result$quality_score, "\n")
```
