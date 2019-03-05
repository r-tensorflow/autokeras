
#' Auto-Keras Model
#'
#' TabularClassifier class.
#'
#' @param path A path to the directory to save the classifier as well as
#' intermediate results.
#' @param verbose A boolean of whether the search process will be printed to
#' stdout.
#'
#' @export
model_tabular_classifier <- function(path=NULL, verbose=TRUE) {
  new("AutokerasModel",
      model=autokeras$TabularClassifier(path=path, verbose=verbose)
  );
}
