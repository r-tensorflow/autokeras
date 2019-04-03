
#' Auto-Keras Model
#'
#' ImageClassifier class.
#' It is used for image classification. It searches convolutional neural
#' network architectures for the best configuration for the image dataset.
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
#' @param augment A boolean value indicating whether the data needs
#' augmentation. True by default.
# @param resize_height resize image height.
# @param resize_width resize image width.
#' @param resume A boolean. If True, the classifier will continue to previous
#' work saved in path. Otherwise, the classifier will start a new search.
#'
# @param cnn: CNN module from net_module.py.
# @param y_encoder: Label encoder, used in transform_y or inverse_transform_y
# for encode the label. For example, if one hot encoder needed, y_encoder can be
# OneHotEncoder.
# @param data_transformer: A transformer class to process the data. See example
# as ImageDataTransformer.
# @param searcher_args: A dictionary containing the parameters for the
# searcher's __init__ function.
#'
#' @importFrom methods new
#'
#' @export
model_image_classifier <- function(path=NULL, verbose=TRUE, augment=TRUE,
                                   resume=FALSE) {
  model <- NULL;
  tryCatch({
    model <- new("AutokerasModel",
                 model=autokeras$ImageClassifier(path=path, verbose=verbose,
                                                 augment=augment, resume=resume)
    )},
    error = function(e) {
      warning(
        "Model not included in current AutoKeras Python installed version.",
        call. = FALSE)
    }
  )
  return(model);
}
