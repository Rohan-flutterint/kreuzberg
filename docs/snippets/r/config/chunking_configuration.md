```r
library(kreuzberg)

# Configure text chunking for RAG pipelines
config <- extraction_config(
  chunking = chunking_config(
    max_characters = 1000L,
    overlap = 200L
  )
)

result <- extract_file_sync("large_document.pdf", config = config)
cat("Number of chunks:", length(result$chunks), "\n")
for (chunk in result$chunks) {
  cat("Chunk:", substr(chunk$content, 1, 50), "...\n")
}
```

```r title="R - Prepend Heading Context"
library(kreuzberg)

# Prepend heading context to chunk content for structured documents
config <- extraction_config(
  chunking = chunking_config(
    chunker_type = "markdown",
    max_characters = 500L,
    overlap = 50L,
    prepend_heading_context = TRUE
  )
)

result <- extract_file_sync("document.md", "text/markdown", config)
cat("Number of chunks:", length(result$chunks), "\n")
for (chunk in result$chunks) {
  # Each chunk's content is prefixed with its heading breadcrumb
  cat("Chunk:", substr(chunk$content, 1, 80), "...\n")
}
```
