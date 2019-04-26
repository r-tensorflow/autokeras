
#' Return the best trained Keras architecture.
#'
#' @param autokeras_model A trained AutokerasModel instance.
#'
#' @name get_keras_model
NULL

#' @rdname get_keras_model
#' @export
get_keras_model <- function(autokeras_model) {
  UseMethod("get_keras_model")
}

#' @rdname get_keras_model
#' @importFrom keras load_model_hdf5
#' @export
get_keras_model.AutokerasModel <- function(autokeras_model) {
  tmp_file <- tempfile(fileext=".h5");
  keras_model <- NULL;
  if (export_keras_model(autokeras_model, tmp_file))
    keras_model <- keras::load_model_hdf5(tmp_file);
  return(keras_model);
}
