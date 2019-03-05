
#' Auto-Keras Model
#'
#' A TextClassifier class based on Google AI's BERT model.
#'
#' @param path A path to the directory to save the classifier as well as
#' intermediate results.
# @param device Specific hardware for using/running the model. E.g:- CPU, GPU
# or TPU.
#' @param verbose A boolean of whether the search process will be printed to
#' stdout.
# @param bert_model Type of BERT model to be used for the classification task.
# E.g:- Uncased, Cased, etc.
# @param tokenizer Tokenizer used with BERT model.
# @param num_labels Number of output labels for the classification task.
# @param output_model_file File location to save the trained model.
#'
#' @export
model_text_classifier <- function(path=NULL, verbose=TRUE) {
  new("AutokerasModel",
      model=autokeras$TextClassifier(path=path, verbose=verbose)
  );
}
