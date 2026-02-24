#' Clear the extraction cache
#'
#' @export
clear_cache <- function() {
  check_native_result(clear_cache_native())
}

#' Get cache statistics
#'
#' @return Named list with total_entries and total_size_bytes.
#' @export
cache_stats <- function() {
  check_native_result(cache_stats_native())
}
