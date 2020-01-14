#' R interface to Auto-Keras
#'
#' [Auto-Keras](https://autokeras.com/) is an open source software library for
#' automated machine learning (AutoML). It is developed by
#' [DATA Lab](http://faculty.cs.tamu.edu/xiahu/index.html) at Texas A&M
#' University and community contributors. The ultimate goal of AutoML is to
#' provide easily accessible deep learning tools to domain experts with limited
#' data science or machine learning background. Auto-Keras provides functions
#' to automatically search for architecture and hyperparameters of deep
#' learning models.
#'
#' @importFrom reticulate import
"_PACKAGE"

# Main Keras module
autokeras <- NULL

.onLoad <- function(libname, pkgname) {
  # delay load keras
  autokeras <<- reticulate::import("autokeras", delay_load = list(
    # todo: remove? priority, and get_module not documented in
    # reticulate package
    priority = 10,
    environment = "r-tensorflow",
    get_module = function() {
      "autokeras"
    },
    on_load = function() {
      NULL
    },
    on_error = function(e) {
      NULL
    }
  ))
}
