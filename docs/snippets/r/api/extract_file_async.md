```r title="R"
library(kreuzberg)

# Note: extract_file() blocks in R despite being async
result <- extract_file("path/to/document.docx")

# Access extraction results
cat("Extracted", length(result$elements), "elements\n")
cat("Detected language:", result$detected_language, "\n")
cat("Tables found:", length(result$tables), "\n")

if (!is.null(result$keywords)) {
  cat("Keywords:", paste(result$keywords, collapse = ", "), "\n")
}
```
