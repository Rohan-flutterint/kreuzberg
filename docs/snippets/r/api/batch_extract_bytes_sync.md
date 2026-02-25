```r title="R"
library(kreuzberg)

# Read multiple files as binary data
data1 <- readBin("document1.pdf", what = "raw", n = file.size("document1.pdf"))
data2 <- readBin("document2.pdf", what = "raw", n = file.size("document2.pdf"))

data_list <- list(data1, data2)
mime_types <- c("application/pdf", "application/pdf")

# Batch extract from bytes
results <- batch_extract_bytes_sync(data_list, mime_types)

# Process results
for (i in seq_along(results)) {
  cat(sprintf("Document %d: %d pages\n", i, page_count(results[[i]])))
}
```
