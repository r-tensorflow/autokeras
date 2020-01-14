#' Auto-Keras Model
#'
#' AutoKeras text classification class.
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
      model <- new("AutokerasModel",
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
        "Model not included in current AutoKeras Python installed version.",
        call. = FALSE
      )
    }
  )
  return(model)
}
