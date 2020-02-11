#' Model Predictions
#'
#' Predict the output for a given testing data.
#'
#' @param object : A trained AutokerasModel instance.
#' @param x : Any allowed types according to the input node. Testing data. Check
#'   corresponding AutokerasModel help to note how it should be provided.
#' @param batch_size : numeric. Defaults to `32`.
#' @param ... : Unused.
#'
#' @return A one-column matrix with the predicted values as rows.
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
#' @importFrom stats predict
#' @rawNamespace export(predict)
#'
#' @name predict
NULL

#' @rdname predict
#' @export
#'
predict.AutokerasModel <- function(object, x, batch_size = 32, ...) {
  if (object@model_name %in% c("text_classifier", "text_regressor")) {
    x <- np_array(x, dtype = "unicode")
  }

  object@model$predict(x = x, batch_size = as.integer(batch_size))
}
