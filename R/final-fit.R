
#' Final training after found the best architecture.
#'
#' @param autokeras_model A trained AutokerasModel instance.
#' @param x_train An array of training data.
#' @param y_train An array of training targets.
#' @param x_test An array of testing data.
#' @param y_test An array of testing targets.
# @param trainer_args A dictionary containing the parameters of the
# ModelTrainer constructor.
#' @param retrain A boolean of whether reinitialize the weights of the model.
#' @param time_limit The time limit to fit in seconds.
#'
#' @name final_fit
NULL

#' @rdname final_fit
#' @export
final_fit <- function(object, ...) {
  UseMethod("final_fit")
}

#' @rdname final_fit
#' @export
final_fit.AutokerasModel <- function(autokeras_model, x_train, y_train,
                                     x_test, y_test, retrain=FALSE,
                                     time_limit=Inf) {
  setTimeLimit(elapsed=time_limit);
  try({
    autokeras_model@model$final_fit(x_train=x_train, y_train=y_train,
                                    x_test=x_test, y_test=y_test,
                                    retrain=retrain);
  })
  return(invisible(autokeras_model));
}
