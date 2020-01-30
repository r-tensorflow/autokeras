#' AutoKeras Text Regressor Model
#'
#' AutoKeras text regression class.\cr
#' To `fit`, `evaluate` or `predict`, format inputs as:
#' \itemize{
#' \item{
#' x : array. The input data should be array. The data should be one
#'   dimensional. Each element in the data should be a string which is a full
#'   sentence.
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
#'   "text_regressor".
#' @param max_trials : numeric. The maximum number of different Keras Models to
#'   try. The search may finish before reaching the `max_trials`. Defaults to
#'   `100`.
#' @param directory : character. The path to a directory for storing the search
#'   outputs. Defaults to `tempdir()`, which would create a folder with the name
#'   of the AutoModel in the current directory.
#' @param objective : character. Name of model metric to minimize or maximize,
#'   e.g. "val_accuracy". Defaults to "val_loss".
#' @param overwrite : logical. Defaults to `TRUE`. If `FALSE`, reloads an
#'   existing project of the same name if one is found. Otherwise, overwrites
#'   the project.
#' @param seed : numeric. Random seed. Defaults to `runif(1, 0, 10e6)`.
#'
#' @examples
#' \donttest{\dontrun{
#' library("keras")
#'
#' # Get IMDb dataset
#' imdb <- dataset_imdb(num_words = 1000)
#' c(x_train, y_train) %<-% imdb$train
#' c(x_test, y_test) %<-% imdb$test
#'
#' # AutoKeras procceses each text data point as a character vector,
#' # i.e., x_train[[1]] "<START> this film was just brilliant casting..",
#' # so we need to transform the dataset.
#' word_index <- dataset_imdb_word_index()
#' word_index <- c(
#'   "<PAD>", "<START>", "<UNK>", "<UNUSED>",
#'   names(word_index)[order(unlist(word_index))]
#' )
#' x_train <- lapply(x_train, function(x) {
#'   paste(word_index[x + 1], collapse = " ")
#' })
#' x_test <- lapply(x_test, function(x) {
#'   paste(word_index[x + 1], collapse = " ")
#' })
#'
#' x_train <- array(unlist(x_train))
#' x_test <- array(unlist(x_test))
#' y_train <- matrix(y_train, ncol = 1)
#' y_test <- matrix(y_test, ncol = 1)
#'
#' library("autokeras")
#'
#' # Initialize the text regressor
#' reg <- model_text_regressor(max_trials = 10) %>% # It tries 10 different models
#'   fit(x_train, y_train) # Feed the text regressor with training data
#'
#' # If you want to use own valitadion data do:
#' # reg <- model_text_regressor(max_trials = 10) %>%
#' #   fit(
#' #     x_train,
#' #     y_train,
#' #     validation_data = list(x_test, y_test)
#' #   )
#'
#' # Predict with the best model
#' (predicted_y <- reg %>% predict(x_test))
#'
#' # Evaluate the best model with testing data
#' reg %>% evaluate(x_test, y_test)
#'
#' # Get the best trained Keras model, to work with the keras R library
#' export_model(reg)
#' }}
#'
#' @importFrom stats runif
#' @importFrom methods new
#'
#' @export
#'
model_text_regressor <- function(output_dim = NULL,
                                 loss = "mean_squared_error",
                                 metrics = NULL,
                                 name = "text_regressor",
                                 max_trials = 100,
                                 directory = tempdir(),
                                 objective = "val_loss",
                                 overwrite = TRUE,
                                 seed = runif(1, 0, 10e6)) {
  if (!is.null(output_dim)) {
    output_dim <- as.integer(output_dim)
  }

  new(
    "AutokerasModel",
    model_name = "text_regressor",
    model = autokeras$TextRegressor(
      output_dim = output_dim, loss = loss, metrics = metrics, name = name,
      max_trials = as.integer(max_trials), directory = directory,
      objective = objective, overwrite = overwrite, seed = as.integer(seed)
    )
  )
}
