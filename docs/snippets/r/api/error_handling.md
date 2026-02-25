```r title="R"
library(kreuzberg)

# Handle extraction errors with typed conditions
result <- tryCatch({
  extract_file_sync("document.xyz")
},
  UnsupportedFileType = function(e) {
    cat("Error: File type not supported\n")
    cat("Message:", conditionMessage(e), "\n")
    NULL
  },
  ValidationError = function(e) {
    cat("Error: Validation failed\n")
    cat("Message:", conditionMessage(e), "\n")
    NULL
  },
  kreuzberg_error = function(e) {
    cat("Error: Kreuzberg extraction failed\n")
    cat("Message:", conditionMessage(e), "\n")
    NULL
  }
)

if (!is.null(result)) {
  cat("Extraction successful\n")
}
```
