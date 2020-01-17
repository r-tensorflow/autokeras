#' Export model
#'
#' Export the best trained Keras Model.
#'
#' @param autokeras_model : A trained AutokerasModel instance.
#'
#' @return keras.Model instance. The best model found during the search, loaded
#'   with trained weights.
#'
#' @export
#'
export_model <- function(autokeras_model) {
  ran_ok <- !inherits(try({
    keras_model <- autokeras_model@model$export_model()
  }), "try-error")

  if (!ran_ok) {
    cat("Could not export Keras model.")
  }

  return(keras_model)
}
