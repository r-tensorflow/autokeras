#' Evaluate a Model
#'
#' Evaluate the best model for the given data.
#'
#' @param object : A trained AutokerasModel instance.
#' @param x_test : Any allowed types according to the input node. Testing data.
#'   Check corresponding AutokerasModel help to note how it should be provided.
#' @param y_test : Any allowed types according to the input node. Testing data.
#'   Check corresponding AutokerasModel help to note how it should be provided.
#'   Defaults to `NULL`.
#' @param batch_size : numeric. Defaults to `32`.
#' @param ... : Unused.
#'
#' @return numeric test loss (if the model has a single output and no metrics)
#'   or list of scalars (if the model has multiple outputs and/or metrics). The
#'   attribute model$metrics_names will give you the display labels for the
#'   scalar outputs.
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
#' @importFrom keras evaluate
#' @rawNamespace export(evaluate)
#'
#' @name evaluate
NULL

#' @rdname evaluate
#' @export
#'
evaluate.AutokerasModel <- function(object,
                                    x_test,
                                    y_test = NULL,
                                    batch_size = 32,
                                    ...) {
  if (object@model_name %in% c("text_classifier", "text_regressor")) {
    x_test <- np_array(x_test, dtype = "unicode")
  }

  object@model$evaluate(
    x = x_test, y = y_test, batch_size = as.integer(batch_size)
  )
}
