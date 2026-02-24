#' @export
register_ocr_backend <- function(name, callback) {
  check_native_result(register_ocr_backend_native(name, callback))
}

#' @export
unregister_ocr_backend <- function(name) {
  check_native_result(unregister_ocr_backend_native(name))
}

#' @export
list_ocr_backends <- function() {
  check_native_result(list_ocr_backends_native())
}

#' @export
clear_ocr_backends <- function() {
  check_native_result(clear_ocr_backends_native())
}

#' @export
register_post_processor <- function(name, callback) {
  check_native_result(register_post_processor_native(name, callback))
}

#' @export
unregister_post_processor <- function(name) {
  check_native_result(unregister_post_processor_native(name))
}

#' @export
list_post_processors <- function() {
  check_native_result(list_post_processors_native())
}

#' @export
clear_post_processors <- function() {
  check_native_result(clear_post_processors_native())
}

#' @export
register_validator <- function(name, callback) {
  check_native_result(register_validator_native(name, callback))
}

#' @export
unregister_validator <- function(name) {
  check_native_result(unregister_validator_native(name))
}

#' @export
list_validators <- function() {
  check_native_result(list_validators_native())
}

#' @export
clear_validators <- function() {
  check_native_result(clear_validators_native())
}

#' @export
list_document_extractors <- function() {
  check_native_result(list_document_extractors_native())
}

#' @export
unregister_document_extractor <- function(name) {
  check_native_result(unregister_document_extractor_native(name))
}

#' @export
clear_document_extractors <- function() {
  check_native_result(clear_document_extractors_native())
}
