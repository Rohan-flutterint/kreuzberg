#' Create an extraction configuration
#'
#' @param force_ocr Logical. Force OCR processing. Default FALSE.
#' @param ocr OCR configuration created by \code{ocr_config()}.
#' @param chunking Chunking configuration created by \code{chunking_config()}.
#' @param output_format Output format string (e.g., "text", "markdown").
#' @param ... Additional configuration options.
#' @return A named list representing the extraction configuration.
#' @export
extraction_config <- function(force_ocr = FALSE, ocr = NULL, chunking = NULL,
                              output_format = NULL, ...) {
  config <- list()
  if (isTRUE(force_ocr)) config$force_ocr <- TRUE
  if (!is.null(ocr)) config$ocr <- ocr
  if (!is.null(chunking)) config$chunking <- chunking
  if (!is.null(output_format)) config$output_format <- output_format
  extras <- list(...)
  if (length(extras) > 0) config <- c(config, extras)
  config
}

#' Create an OCR configuration
#'
#' @param backend OCR backend name (e.g., "tesseract", "paddle-ocr").
#' @param language Language code for OCR (e.g., "eng", "deu").
#' @param dpi DPI for image processing.
#' @param ... Additional OCR options.
#' @return A named list representing the OCR configuration.
#' @export
ocr_config <- function(backend = "tesseract", language = "eng", dpi = NULL, ...) {
  config <- list(backend = backend, language = language)
  if (!is.null(dpi)) config$dpi <- as.integer(dpi)
  extras <- list(...)
  if (length(extras) > 0) config <- c(config, extras)
  config
}

#' Create a chunking configuration
#'
#' @param max_characters Maximum characters per chunk.
#' @param overlap Number of overlapping characters between chunks.
#' @param ... Additional chunking options.
#' @return A named list representing the chunking configuration.
#' @export
chunking_config <- function(max_characters = 1000L, overlap = 200L, ...) {
  config <- list(
    max_characters = as.integer(max_characters),
    overlap = as.integer(overlap)
  )
  extras <- list(...)
  if (length(extras) > 0) config <- c(config, extras)
  config
}

#' Discover extraction configuration from kreuzberg.toml
#'
#' Searches for a kreuzberg.toml file in the current directory and parent
#' directories. Returns the parsed configuration or NULL if not found.
#'
#' @return A named list representing the extraction configuration, or NULL.
#' @export
discover <- function() {
  json <- check_native_result(config_discover_native())
  if (is.null(json)) {
    return(NULL)
  }
  jsonlite::fromJSON(json, simplifyVector = FALSE)
}

#' Load extraction configuration from a file
#'
#' Reads and parses a configuration file. Supports TOML, YAML, and JSON formats
#' (auto-detected from file extension).
#'
#' @param path Path to the configuration file.
#' @return A named list representing the extraction configuration.
#' @export
from_file <- function(path) {
  json <- check_native_result(config_from_file_native(path))
  if (is.null(json)) {
    return(NULL)
  }
  jsonlite::fromJSON(json, simplifyVector = FALSE)
}
