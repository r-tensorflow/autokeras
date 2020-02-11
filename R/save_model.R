#' Save Model
#'
#' Save the AutoKeras Model.\cr
#' Make sure that `directory` and `name` values are set when creating the model,
#' and that the `directory` is not a temporary folder.
#'
#' @param autokeras_model : A trained AutokerasModel instance.
#' @param filename : A character string naming a file to save the model.
#'
#' @return None
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
#' clf <- model_image_classifier(
#'   directory = ".",
#'   name = "autokeras_mnist",
#'   max_trials = 10
#' ) %>% # It tries 10 different models
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
#'
#' # Save the AutoKeras model.
#' # Make sure that `directory` and `name` were set when creating the model.
#' save_model(clf, "my_model.pkl")
#'
#' # And load it again
#' new_clf <- load_model("my_model.pkl")
#' }
#'
#' @importFrom reticulate py_save_object
#'
#' @export
#'
save_model <- function(autokeras_model, filename) {
  filename <- normalizePath(filename, mustWork = FALSE)
  if (grepl("^/tmp/", autokeras_model@model$directory)) {
    warning("Make sure that the model directory is not temporary.")
  }
  py_save_object(autokeras_model@model, filename)
  invisible(NULL)
}
