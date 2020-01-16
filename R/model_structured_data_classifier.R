#' Auto-Keras Model
#'
#' AutoKeras structured data classification class.
#' To `fit`, `evaluate` or `predict`, format inputs as:
#' \itemize{
#' \item{
#' x : character or array. If the data is from a csv file, it should be a
#'   character specifying the path of the csv file of the training data.
#' }
#' \item{
#' y : character or array. If the data is from a csv file, it should be a
#'   character, which is the name of the target column. Otherwise, It can be raw
#'   labels, one-hot encoded if more than two classes, or binary encoded for
#'   binary classification.
#' }
#' }
#'
#' Important: The object returned by this function behaves like an R6 object,
#' i.e., within function calls with this object as parameter, it is most likely
#' that the object will be modified. Therefore it is not necessary to assign
#' the result of the functions to the same object.
#'
#' @param column_names : A list of characters specifying the names of the
#'   columns. The length of the list should be equal to the number of columns of
#'   the data excluding the target column. Defaults to `NULL`. If `NULL`, it
#'   will obtained from the header of the csv file or the `data.frame`.
#' @param column_types : A list of characters. The names are the column names.
#'   The values should either be 'numerical' or 'categorical', indicating the
#'   type of that column. Defaults to `NULL`. If not `NULL`, the `column_names`
#'   need to be specified. If `NULL`, it will be inferred from the data.
#' @param num_classes : numeric. Defaults to `NULL`. If `NULL`, it will infer
#'   from the data.
#' @param multi_label : logical. Defaults to `FALSE`.
#' @param loss : A Keras loss function. Defaults to use "binary_crossentropy" or
#'   "categorical_crossentropy" based on the number of classes.
#' @param metrics : A list of Keras metrics. Defaults to use "accuracy".
#' @param name : character. The name of the AutoModel. Defaults to
#'   "structured_data_classifier".
#' @param max_trials : numeric. The maximum number of different Keras Models to
#'   try. The search may finish before reaching the `max_trials`. Defaults to
#'   `100`.
#' @param directory : character. The path to a directory for storing the search
#'   outputs. Defaults to `NULL`, which would create a folder with the name of
#'   the AutoModel in the current directory.
#' @param objective : character. Name of model metric to minimize or maximize.
#'   Defaults to "val_accuracy".
#' @param overwrite : logical. Defaults to `TRUE`. If `FALSE`, reloads an
#'   existing project of the same name if one is found. Otherwise, overwrites
#'   the project.
#' @param seed : numeric. Random seed.
#'
#' @examples
#' # Create a structured data classifier
#' clf <- model_structured_data_classifier()
#'
#' \dontrun{
#' library("autokeras")
#' library("keras")
#'
#' # use the iris dataset as an example
#' set.seed(8818)
#' # balanced sample 80% for training
#' train_idxs <- unlist(by(seq_len(nrow(iris)), iris$Species, function(x)
#'   sample(x, length(x) * .8)
#' ))
#' train_data <- iris[train_idxs, ]
#' test_data <- iris[-train_idxs, ]
#'
#' colnames(iris)
#' # Species will be the interest column to predict
#'
#' train_file <- paste0(tempdir(), "/iris_train.csv")
#' write.csv(train_data, train_file, row.names = FALSE)
#'
#' # file to predict, cant have the response "Species" column
#' test_file_to_predict <- paste0(tempdir(), "/iris_test_2_pred.csv")
#' write.csv(test_data[, -5], test_file_to_predict, row.names = FALSE)
#'
#' test_file_to_eval <- paste0(tempdir(), "/iris_test_2_eval.csv")
#' write.csv(test_data, test_file_to_eval, row.names = FALSE)
#'
#' # Initialize the structured data classifier
#' clf <- model_structured_data_classifier(max_trials = 10) %>% # It tries 10 different models
#'   fit(train_file, "Species") # Feed the structured data classifier with training data
#'
#'# Predict with the best model
#'(predicted_y <- clf %>% predict(test_file_to_predict))
#'
#'# Evaluate the best model with testing data
#'clf %>% evaluate(test_file_to_eval, "Species")
#' }
#'
#' @importFrom methods new
#'
#' @export
#'
model_structured_data_classifier <- function(column_names = NULL,
                                             column_types = NULL,
                                             num_classes = NULL,
                                             multi_label = FALSE,
                                             loss = NULL,
                                             metrics = NULL,
                                             name = "structured_data_classifier",
                                             max_trials = 100,
                                             directory = NULL,
                                             objective = "val_accuracy",
                                             overwrite = TRUE,
                                             seed = NULL) {
  model <- NULL
  tryCatch(
    {
      model <- new(
        "AutokerasModel",
        model_name = "structured_data_classifier",
        model = autokeras$StructuredDataClassifier(
          column_names = column_names, column_types = column_types,
          num_classes = num_classes, multi_label = multi_label, loss = loss,
          metrics = metrics, name = name, max_trials = max_trials,
          directory = directory, objective = objective, overwrite = overwrite,
          seed = seed
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
