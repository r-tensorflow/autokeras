
#' Auto-Keras Model
#'
#' TextRegressor class.
#'
#' @param path A path to the directory to save the classifier as well as
#' intermediate results.
#' @param verbose A boolean of whether the search process will be printed to
#' stdout.
#'
#' @export
model_text_regressor <- function(path=NULL, verbose=TRUE) {
  new("AutokerasModel",
      model=autokeras$TextRegressor(path=path, verbose=verbose)
  );
}
