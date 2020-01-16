#' Evaluate a model
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
#' @examples
#' \dontrun{
#' library("autokeras")
#' library("keras")
#'
#' # use the MNIST dataset as an example
#' mnist <- dataset_mnist()
#' c(x_train, y_train) %<-% mnist$train
#' c(x_test, y_test) %<-% mnist$test
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
#' }
#'
#' @importFrom generics evaluate
#' @rawNamespace export(evaluate)
#'
#' @name evaluate
NULL

#' @rdname evaluate
#' @export
#'
evaluate.AutokerasModel <- function(autokeras_model,
                                    x,
                                    y = NULL,
                                    batch_size = 32) {
  if (autokeras_model@model_name %in% c("text_classifier", "text_regressor")) {
    x <- np_array(x, dtype = "unicode")
  }

  autokeras_model@model$evaluate(
    x = x, y = y, batch_size = as.integer(batch_size)
  )
}
