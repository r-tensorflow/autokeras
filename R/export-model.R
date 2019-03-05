
#' Creates and exports the Keras or AutoKeras model to the given filename.
#'
#' @param model_file_name Output file path to save the model. File should be
#' .h5 for Keras, and .pkl for AutoKeras.
#'
#' @name export_model
NULL

#' @rdname export_model
#' @export
export_keras_model <- function(object, ...) {
  UseMethod("export_keras_model")
}

#' @rdname export_model
#' @export
export_keras_model.AutokerasModel <-
  function(autokeras_model, model_file_name) {
    model_file_name <- normalizePath(model_file_name, mustWork=F);
    autokeras_model@model$export_keras_model(model_file_name=model_file_name);
  }

#' @rdname export_model
#' @export
export_autokeras_model <- function(object, ...) {
  UseMethod("export_autokeras_model")
}

#' @rdname export_model
#' @export
export_autokeras_model.AutokerasModel <-
  function(autokeras_model, model_file_name) {
    model_file_name <- normalizePath(model_file_name, mustWork=F);
    autokeras_model@model$export_autokeras_model(model_file_name=
                                                   model_file_name);
  }
