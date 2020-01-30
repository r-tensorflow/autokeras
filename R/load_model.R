#' Load Model
#'
#' Load an AutoKeras Model.
#'
#' @param filename : A character string naming a file to save the model.
#'
#' @return A previously saved AutokerasModel.
#'
#' @examples
#' \donttest{\dontrun{
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
#' }}
#'
#' @importFrom reticulate py_load_object
#'
#' @export
#'
load_model <- function(filename) {
  filename <- normalizePath(filename)
  ak_model <- py_load_object(filename)
  my_model_pkl <- new(
    "AutokerasModel",
    model_name = get_model_name(ak_model),
    model = ak_model
  )
}

#' @importFrom methods is
#'
get_model_name <- function(ak_model) {
  if (is(ak_model, "autokeras.task.ImageClassifier")) {
    "image_classifier"
  } else if (is(ak_model, "autokeras.task.ImageRegressor")) {
    "image_regressor"
  } else if (is(ak_model, "autokeras.task.StructuredDataClassifier")) {
    "structured_data_classifier"
  } else if (is(ak_model, "autokeras.task.StructuredDataRegressor")) {
    "structured_data_regressor"
  } else if (is(ak_model, "autokeras.task.TextRegressor")) {
    "text_regressor"
  } else if (is(ak_model, "autokeras.task.TextClassifier")) {
    "text_classifier"
  } else {
    "unknown"
  }
}
