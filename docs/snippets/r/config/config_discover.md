```r title="R"
library(kreuzberg)

# Discover kreuzberg.toml from current or parent directories
config <- discover()

if (!is.null(config)) {
  cat("Found kreuzberg.toml configuration\n")
  result <- extract_file_sync("document.pdf", config = config)
  cat(sprintf("Extracted %d characters\n", nchar(result$content)))
}

# Or load config from a specific file
config <- from_file("config.yaml")

if (!is.null(config)) {
  cat("Loaded configuration from config.yaml\n")
  result <- extract_file_sync("document.pdf", config = config)
  cat(sprintf("Extracted %d characters\n", nchar(result$content)))
}
```
