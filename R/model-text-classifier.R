
#' Auto-Keras Model
#'
#' A TextClassifier class based on Google AI's BERT model.
#'
#' Important: The object returned by this function behaves like an R6 object,
#' i.e., within function calls with this object as parameter, it is most likely
#' that the object will be modified. Therefore it is not necessary to assign
#' the result of the functions to the same object.
#'
#' @param path A path to the directory to save the classifier as well as
#' intermediate results.
# @param device Specific hardware for using/running the model. E.g:- CPU, GPU
# or TPU.
#' @param verbose A boolean of whether the search process will be printed to
#' stdout.
#'
# @param bert_model Type of BERT model to be used for the classification task.
# E.g:- Uncased, Cased, etc.
# @param tokenizer Tokenizer used with BERT model.
# @param num_labels Number of output labels for the classification task.
# @param output_model_file File location to save the trained model.
#'
#' @importFrom methods new
#'
#' @export
model_text_classifier <- function(path=NULL, verbose=TRUE) {
  model <- NULL;
  tryCatch({
    model <- new("AutokerasModel",
                 model=autokeras$TextClassifier(path=path, verbose=verbose)
    )},
    error = function(e) {
      warning(
        "Model not included in current AutoKeras Python installed version.",
        call. = FALSE)
    }
  )
  return(model);
}
