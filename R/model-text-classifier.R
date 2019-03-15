
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
#' @param glove_file A path where the glove.zip must be downloaded, or where it
#' was previously downloaded. This file is going to be used by Auto-Keras to
#' train the model. GloVe: Global Vectors for Word Representation.
#'
# @param bert_model Type of BERT model to be used for the classification task.
# E.g:- Uncased, Cased, etc.
# @param tokenizer Tokenizer used with BERT model.
# @param num_labels Number of output labels for the classification task.
# @param output_model_file File location to save the trained model.
#'
#' @importFrom methods new
#' @importFrom utils download.file
#'
#' @export
model_text_classifier <- function(path=NULL, verbose=TRUE, glove_file=NULL) {
  glove_reg_file <- "/tmp/autokeras_store/glove.zip";
  if (!is.null(glove_file)) {
    if (!file.exists(glove_file)) {
      download.file("http://nlp.stanford.edu/data/glove.6B.zip", glove_file);
    }
    # if glove file doesnt exists, or is corrupted
    if (!file.exists(glove_reg_file) ||
        file.size(glove_reg_file) != file.size(glove_file)) {
      dir.create("/tmp/autokeras_store/", showWarnings = FALSE,
                 recursive = TRUE);
      file.copy(glove_file, glove_reg_file, overwrite = TRUE);
    }
  }

  new("AutokerasModel",
      model=autokeras$TextClassifier(path=path, verbose=verbose)
  );
}
