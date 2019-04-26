
#' Return predict results for the testing data.
#'
#' @param object A trained AutokerasModel instance.
#' @param x_test An array containing the testing data.
#' @param ... Unused
#'
#' @name predict
#'
#' @importFrom stats predict
#' @export
predict.AutokerasModel <- function(object, x_test, ...) {
  object@model$predict(x_test=x_test);
}
