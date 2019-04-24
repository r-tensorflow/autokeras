
#' Export and import functions for Keras and AutoKeras models.
#'
#' Creates and exports the Keras or AutoKeras model to the given filename.
#' Or imports the previously exported AutoKeras model.
#'
#' @param autokeras_model A trained AutokerasModel instance.
#' @param model_file_name Output/Input file path to save/load the model. File
#' should be .h5 for Keras, and .pkl for AutoKeras.
#'
#' @name export_model
NULL

#' @rdname export_model
#' @export
export_keras_model <- function(autokeras_model, model_file_name) {
  UseMethod("export_keras_model")
}

#' @rdname export_model
#' @export
export_keras_model.AutokerasModel <-
  function(autokeras_model, model_file_name) {
    model_file_name <- normalizePath(model_file_name, mustWork=F);
    ran_ok <- !inherits(try({
      autokeras_model@model$export_keras_model(model_file_name=model_file_name);
    }), 'try-error');

    if (!ran_ok)
      cat("Could not export keras model.")
    return(invisible(ran_ok))
  }

#' @rdname export_model
#' @export
export_autokeras_model <- function(autokeras_model, model_file_name) {
  UseMethod("export_autokeras_model")
}

#' @rdname export_model
#' @export
export_autokeras_model.AutokerasModel <-
  function(autokeras_model, model_file_name) {
    model_file_name <- normalizePath(model_file_name, mustWork=F);
    ran_ok <- !inherits(try({
      autokeras_model@model$export_autokeras_model(model_file_name=
                                                     model_file_name);
    }), 'try-error');

    if (!ran_ok)
      cat("Could not export keras model.")
    return(invisible(ran_ok))
  }

#' @rdname export_model
#' @export
import_autokeras_model <- function(model_file_name) {
  UseMethod("import_autokeras_model")
}

#' @rdname export_model
#' @importFrom methods new
#'
#' @export
import_autokeras_model.character <- function(model_file_name) {
  model_file_name <- normalizePath(model_file_name, mustWork=F);
  new("AutokerasModel",
      model=autokeras$utils$pickle_from_file(model_file_name));
}
