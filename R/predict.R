
#' Return predict results for the testing data.
#'
#' @param autokeras_model A trained AutokerasModel instance.
#' @param x_test An array containing the testing data.
#'
#' @name predict
NULL

#' @rdname predict
# @export
#' @export predict.AutokerasModel
predict.AutokerasModel <- function(autokeras_model, x_test) {
  autokeras_model@model$predict(x_test=x_test);
}
