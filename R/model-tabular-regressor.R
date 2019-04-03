
#' Auto-Keras Model
#'
#' TabularRegressor class.
#'
#' Important: The object returned by this function behaves like an R6 object,
#' i.e., within function calls with this object as parameter, it is most likely
#' that the object will be modified. Therefore it is not necessary to assign
#' the result of the functions to the same object.
#'
#' @param path A path to the directory to save the classifier as well as
#' intermediate results.
#'
#' @importFrom methods new
#'
#' @export
model_tabular_regressor <- function(path=NULL) {
  model <- NULL;
  tryCatch({
    model <- new("AutokerasModel",
                 model=autokeras$TabularRegressor(path=path)
    )},
    error = function(e) {
      warning(
        "Model not included in current AutoKeras Python installed version.",
        call. = FALSE)
    }
  )
  return(model);
}
