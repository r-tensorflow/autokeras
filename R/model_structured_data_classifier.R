#' Auto-Keras Model
#'
#' AutoKeras structured data classification class.
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
      model <- new("AutokerasModel",
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
