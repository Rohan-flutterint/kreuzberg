```r title="R"
library(kreuzberg)

# Define file paths to extract
file_paths <- c(
  "documents/report.pdf",
  "documents/summary.docx",
  "documents/data.xlsx"
)

# Batch extract files
results <- batch_extract_files_sync(file_paths)

# Process results
for (i in seq_along(results)) {
  result <- results[[i]]
  cat(sprintf("File %d: %s\n", i, file_paths[i]))
  cat(sprintf("  Pages: %d\n", page_count(result)))
  cat(sprintf("  Elements: %d\n", length(result$elements)))
}
```
