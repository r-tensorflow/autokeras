
#' Return the accuracy score between predict value and y_test.
#'
#' @param autokeras_model A trained AutokerasModel instance.
#' @param x_test An array containing the testing data.
#' @param y_test An array containing the testing targets.
#'
#' @name evaluate
NULL

#' @rdname evaluate
#' @export
evaluate.AutokerasModel <- function(autokeras_model, x_test, y_test) {
  autokeras_model@model$evaluate(x_test=x_test, y_test=y_test);
}
