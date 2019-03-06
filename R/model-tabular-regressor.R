
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
#' @param verbose A boolean of whether the search process will be printed to
#' stdout.
#'
#' @importFrom methods new
#'
#' @export
model_tabular_regressor <- function(path=NULL, verbose=TRUE) {
  new("AutokerasModel",
      model=autokeras$TabularRegressor(path=path, verbose=verbose)
  );
}
