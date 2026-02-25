```r title="R"
library(kreuzberg)

config <- extraction_config(
  result_format = "element_based",
  output_format = "markdown"
)

file_path <- "document.pdf"
result <- extract_file_sync(file_path, config = config)

cat(sprintf("Total elements: %d\n\n", length(result$elements)))

for (i in seq_along(result$elements)) {
  element <- result$elements[[i]]
  cat(sprintf("Element %d:\n", i))
  cat(sprintf("  Type: %s\n", element$element_type))
  cat(sprintf("  Content: %s\n\n", substr(element$content, 1, 100)))
}
```
