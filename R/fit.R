#' Search for the best model and hyperparameters for the AutoModel.
#'
#' It will search for the best model and hyperparameters based on the
#' performances on validation data.
#'
#' @param autokeras_model : An AutokerasModel instance.
#' @param x : Training data x. Check corresponding AutokerasModel help to note
#'   how it should be provided.
#' @param y : Training data y. Check corresponding AutokerasModel help to note
#'   how it should be provided.
#' @param epochs : numeric. The number of epochs to train each model during the
#'   search. If unspecified, by default we train for a maximum of `1000` epochs,
#'   but we stop training if the validation loss stops improving for 10 epochs
#'   (unless you specified an EarlyStopping callback as part of the `callbacks`
#'   argument, in which case the EarlyStopping callback you specified will
#'   determine early stopping).
#' @param callbacks : list of Keras callbacks to apply during training and
#'   validation.
#' @param validation_split : numeric between 0 and 1. Defaults to `0.2`.
#'   Fraction of the training data to be used as validation data. The model will
#'   set apart this fraction of the training data, will not train on it, and
#'   will evaluate the loss and any model metrics on this data at the end of
#'   each epoch. The validation data is selected from the last samples in the
#'   `x` and `y` data provided, before shuffling. This argument is not supported
#'   when `x` is a dataset. The best model found would be fit on the entire
#'   dataset including the validation data.
#' @param validation_data : Data on which to evaluate the loss and any model
#'   metrics at the end of each epoch. The model will not be trained on this
#'   data. `validation_data` will override `validation_split`. The type of the
#'   validation data should be the same as the training data. The best model
#'   found would be fit on the training dataset without the validation data.
#'
#' @name fit
NULL

#' @rdname fit
#' @export
#'
fit.AutokerasModel <- function(autokeras_model,
                               x = NULL,
                               y = NULL,
                               epochs = NULL,
                               callbacks = NULL,
                               validation_split = 0.2,
                               validation_data = NULL) {
  autokeras_model@model$fit(
    x = x, y = y, epochs = epochs, callbacks = callbacks,
    validation_split = validation_split, validation_data = validation_data
  )
  return(invisible(autokeras_model))
}
