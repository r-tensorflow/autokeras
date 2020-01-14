#' Auto-Keras Model
#'
#' AutoKeras structured data regression class.
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
#' @param output_dim : numeric. The number of output dimensions. Defaults to
#'   `NULL`. If `NULL`, it will infer from the data.
#' @param loss : A Keras loss function. Defaults to use "mean_squared_error".
#' @param metrics : A list of Keras metrics. Defaults to use
#'   "mean_squared_error".
#' @param name : character. The name of the AutoModel. Defaults to
#'   "structured_data_regressor".
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
#' # Create a structured data regressor
#' clf <- model_structured_data_regressor()
#' @importFrom methods new
#'
#' @export
#'
model_structured_data_regressor <- function(column_names = NULL,
                                 column_types = NULL,
                                 output_dim = NULL,
                                 loss = "mean_squared_error",
                                 metrics = NULL,
                                 name = "structured_data_regressor",
                                 max_trials = 100,
                                 directory = NULL,
                                 objective = "val_loss",
                                 overwrite = TRUE,
                                 seed = NULL) {
  model <- NULL
  tryCatch(
    {
      model <- new("AutokerasModel",
        model = autokeras$StructuredDataRegressor(
          column_names = column_names, column_types = column_types,
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
