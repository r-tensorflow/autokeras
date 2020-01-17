#' Auto-Keras text classifier model
#'
#' AutoKeras text classification class.
#' To `fit`, `evaluate` or `predict`, format inputs as:
#' \itemize{
#' \item{
#' x : array. The input data should be array. The data should be one
#'   dimensional. Each element in the data should be a string which is a full
#'   sentence.
#' }
#' \item{
#' y : array. It can be raw labels, one-hot encoded if more than two classes, or
#'   binary encoded for binary classification.
#' }
#' }
#'
#' Important: The object returned by this function behaves like an R6 object,
#' i.e., within function calls with this object as parameter, it is most likely
#' that the object will be modified. Therefore it is not necessary to assign
#' the result of the functions to the same object.
#'
#' @param num_classes : numeric. Defaults to `NULL`. If `NULL`, it will infer
#'   from the data.
#' @param multi_label : logical. Defaults to `FALSE`.
#' @param loss : A Keras loss function. Defaults to use "binary_crossentropy" or
#'   "categorical_crossentropy" based on the number of classes.
#' @param metrics : A list of Keras metrics. Defaults to use "accuracy".
#' @param name : character. The name of the AutoModel. Defaults to
#'   "text_classifier".
#' @param max_trials : numeric. The maximum number of different Keras Models to
#'   try. The search may finish before reaching the `max_trials`. Defaults to
#'   `100`.
#' @param directory : character. The path to a directory for storing the search
#'   outputs. Defaults to `NULL`, which would create a folder with the name of
#'   the AutoModel in the current directory.
#' @param objective : character. Name of model metric to minimize or maximize,
#'   e.g. "val_accuracy". Defaults to "val_loss".
#' @param overwrite : logical. Defaults to `TRUE`. If `FALSE`, reloads an
#'   existing project of the same name if one is found. Otherwise, overwrites
#'   the project.
#' @param seed : numeric. Random seed.
#'
#' @examples
#' # Create a text classifier
#' clf <- model_text_classifier()
#'
#' \dontrun{
#' library("keras")
#'
#' # Get IMDb dataset
#' imdb <- dataset_imdb(num_words = 1000)
#' c(x_train, y_train) %<-% imdb$train
#' c(x_test, y_test) %<-% imdb$test
#'
#' # Auto-Keras procceses each text data point as a character vector,
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
#' # Initialize the text classifier
#' clf <- model_text_classifier(max_trials = 10) %>% # It tries 10 different models
#'   fit(x_train, y_train) # Feed the text classifier with training data
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
#' @importFrom methods new
#'
#' @export
#'
model_text_classifier <- function(num_classes = NULL,
                                  multi_label = FALSE,
                                  loss = NULL,
                                  metrics = NULL,
                                  name = "text_classifier",
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
        model_name = "text_classifier",
        model = autokeras$TextClassifier(
          num_classes = num_classes, multi_label = multi_label, loss = loss,
          metrics = metrics, name = name, max_trials = max_trials,
          directory = directory, objective = objective, overwrite = overwrite,
          seed = seed
        )
      )
    },
    error = function(e) {
      warning(
        paste0(
          "Model not included in current AutoKeras Python installed version?\n",
          e
        ),
        call. = FALSE
      )
    }
  )
  return(model)
}
