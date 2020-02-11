#' Export Model
#'
#' Export the best trained Keras Model.\cr
#' Actually, exporting the model as a Keras model is not working as expected,
#' check out the bug https://github.com/keras-team/autokeras/issues/929 .
#'
#' @param autokeras_model : A trained AutokerasModel instance.
#'
#' @return keras.Model instance. The best model found during the search, loaded
#'   with trained weights.
#'
#' @examples
#' \dontrun{
#' library("keras")
#'
#' # use the MNIST dataset as an example
#' mnist <- dataset_mnist()
#' c(x_train, y_train) %<-% mnist$train
#' c(x_test, y_test) %<-% mnist$test
#'
#' library("autokeras")
#'
#' # Initialize the image classifier
#' clf <- model_image_classifier(max_trials = 10) %>% # It tries 10 different models
#'   fit(x_train, y_train) # Feed the image classifier with training data
#'
#' # Predict with the best model
#' (predicted_y <- clf %>% predict(x_test))
#'
#' # Evaluate the best model with testing data
#' clf %>% evaluate(x_test, y_test)
#'
#' # Get the best trained Keras model, to work with the keras R library
#' export_model(clf)
#' }
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
