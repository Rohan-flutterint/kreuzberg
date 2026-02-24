#' Kreuzberg error condition
#'
#' @param message Error message.
#' @param class Additional error class.
#' @param call The call that triggered the error.
#' @return A condition object.
#' @keywords internal
kreuzberg_error <- function(message, class = NULL, call = NULL) {
  structure(
    class = c(class, "kreuzberg_error", "error", "condition"),
    list(message = message, call = call)
  )
}

#' Check if a native result is an extendr error condition and raise it
#'
#' @param result The result from a native function call.
#' @return The result if not an error; otherwise stops with the error message.
#' @keywords internal
check_native_result <- function(result) {
  if (inherits(result, "extendr_error")) {
    msg <- if (!is.null(result$value)) as.character(result$value) else result$message
    stop(msg, call. = FALSE)
  }
  result
}
