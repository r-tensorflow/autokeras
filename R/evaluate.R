#' Evaluate
#'
#' Evaluate the best model for the given data.
#'
#' @param autokeras_model : A trained AutokerasModel instance.
#' @param x : Any allowed types according to the input node. Testing data. Check
#'   corresponding AutokerasModel help to note how it should be provided.
#' @param y : Any allowed types according to the input node. Testing data. Check
#'   corresponding AutokerasModel help to note how it should be provided.
#'   Defaults to `NULL`.
#' @param batch_size : numeric. Defaults to `32`.
#'
#' @return numeric test loss (if the model has a single output and no metrics)
#'   or list of scalars (if the model has multiple outputs and/or metrics). The
#'   attribute model$metrics_names will give you the display labels for the
#'   scalar outputs.
#'
#' @name evaluate
NULL

#' @rdname evaluate
#' @export
evaluate.AutokerasModel <- function(autokeras_model,
                                    x,
                                    y = NULL,
                                    batch_size = 32) {
  autokeras_model@model$evaluate(x = x, y = y, batch_size = batch_size)
}
