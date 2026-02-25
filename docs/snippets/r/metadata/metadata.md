```r title="R"
library(kreuzberg)

result <- extract_file_sync("document.pdf")

cat("Detected Language:", result$detected_language, "\n")
cat("Quality Score:", result$quality_score, "\n")
cat("Keywords:", paste(result$keywords, collapse=", "), "\n\n")

cat("Metadata fields:\n")
author <- metadata_field(result, "author")
if (!is.null(author)) {
  cat("Author:", author, "\n")
}

created <- metadata_field(result, "created_date")
if (!is.null(created)) {
  cat("Created Date:", created, "\n")
}

pages_meta <- metadata_field(result, "total_pages")
if (!is.null(pages_meta)) {
  cat("Total Pages:", pages_meta, "\n")
}
```
