#' Predict
#'
#' Predict the output for a given testing data.
#'
#' @param object : A trained AutokerasModel instance.
#' @param x : Any allowed types according to the input node. Testing data. Check
#'   corresponding AutokerasModel help to note how it should be provided.
#' @param batch_size : numeric. Defaults to `32`.
#' @param ... : Unused.
#'
#' @name predict
#'
#' @importFrom stats predict
#' @export
predict.AutokerasModel <- function(object, x, batch_size = 32, ...) {
  object@model$predict(x = x, batch_size = batch_size)
}
