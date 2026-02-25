```r title="R"
library(kreuzberg)

config <- extraction_config(
  include_document_structure = TRUE,
  output_format = "markdown"
)

file_path <- "document.pdf"
result <- extract_file_sync(file_path, config = config)

cat(sprintf("Total pages: %d\n", length(result$pages)))
cat(sprintf("MIME type: %s\n\n", result$mime_type))

for (i in seq_along(result$pages)) {
  page <- result$pages[[i]]
  cat(sprintf("Page %d structure:\n", i))
  cat(sprintf("  Content: %s\n", substr(page$content, 1, 100)))
  cat("\n")
}
```
