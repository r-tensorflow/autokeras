#' Auto-Keras image regressor model
#'
#' AutoKeras image regression class.
#' It is used for image regression. It searches convolutional neural network
#' architectures for the best configuration for the image dataset.
#' To `fit`, `evaluate` or `predict`, format inputs as:
#' \itemize{
#' \item{
#' x : array. The shape of the data should be 3 or 4 dimensional, the last
#'   dimension of which should be channel dimension.
#' }
#' \item{
#' y : array. The targets passing to the head would have to be array or
#'   data.frame. It can be single-column or multi-column. The values should all
#'   be numerical.
#' }
#' }
#'
#' Important: The object returned by this function behaves like an R6 object,
#' i.e., within function calls with this object as parameter, it is most likely
#' that the object will be modified. Therefore it is not necessary to assign
#' the result of the functions to the same object.
#'
#' @param output_dim : numeric. The number of output dimensions. Defaults to
#'   `NULL`. If `NULL`, it will infer from the data.
#' @param loss : A Keras loss function. Defaults to use "mean_squared_error".
#' @param metrics : A list of Keras metrics. Defaults to use
#'   "mean_squared_error".
#' @param name : character. The name of the AutoModel. Defaults to
#'   "image_regressor".
#' @param max_trials : numeric. The maximum number of different Keras Models to
#'   try. The search may finish before reaching the `max_trials`. Defaults to
#'   `100`.
#' @param directory : character. The path to a directory for storing the search
#'   outputs. Defaults to `NULL`, which would create a folder with the name of the
#'   AutoModel in the current directory.
#' @param objective : character. Name of model metric to minimize or maximize,
#'   e.g. "val_accuracy". Defaults to "val_loss".
#' @param overwrite : logical. Defaults to `TRUE`. If `FALSE`, reloads an
#'   existing project of the same name if one is found. Otherwise, overwrites
#'   the project.
#' @param seed : numeric. Random seed.
#'
#' @examples
#' # Create an image regressor
#' clf <- model_image_regressor()
#'
#' \dontrun{
#' library("autokeras")
#' library("keras")
#'
#' # use the MNIST dataset as an example
#' mnist <- dataset_mnist()
#' c(x_train, y_train) %<-% mnist$train
#' c(x_test, y_test) %<-% mnist$test
#'
#' # Initialize the image regressor
#' clf <- model_image_regressor(max_trials = 10) %>% # It tries 10 different models
#'   fit(x_train, y_train) # Feed the image regressor with training data
#'
#' # Predict with the best model
#' (predicted_y <- clf %>% predict(x_test))
#'
#' # Evaluate the best model with testing data
#' clf %>% evaluate(x_test, y_test)
#' }
#'
#' @importFrom methods new
#'
#' @export
#'
model_image_regressor <- function(output_dim = NULL,
                                  loss = "mean_squared_error",
                                  metrics = NULL,
                                  name = "image_regressor",
                                  max_trials = 100,
                                  directory = NULL,
                                  objective = "val_loss",
                                  overwrite = TRUE,
                                  seed = NULL) {
  model <- NULL
  tryCatch(
    {
      model <- new(
        "AutokerasModel",
        model_name = "image_regressor",
        model = autokeras$ImageRegressor(
          output_dim = output_dim, loss = loss, metrics = metrics, name = name,
          max_trials = max_trials, directory = directory, objective = objective,
          overwrite = overwrite, seed = seed
        )
      )
    },
    error = function(e) {
      warning(
        "Model not included in current AutoKeras Python installed version.",
        call. = FALSE
      )
    }
  )
  return(model)
}
