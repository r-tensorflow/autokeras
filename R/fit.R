
#' Find the best neural architecture and train it.
#'
#' Based on the given dataset, the function will find the best neural
#' architecture for it.
#' The dataset is in array format.
#' So they training data should be passed through x and y.
#'
#' @param autokeras_model An AutokerasModel instance.
#' @param x An array containing the training data or the training data combined
#' with the validation data.
#' @param y An array containing the label of the training data. or the label of
#' the training data combined with the validation label.
#' @param time_limit The time limit for the search in seconds.
#'
#' @name fit
NULL

#' @rdname fit
#' @export
fit.AutokerasModel <- function(autokeras_model, x, y, time_limit) {
  autokeras_model@model$fit(x=x, y=y, time_limit=time_limit);
  return(invisible(autokeras_model));
}
