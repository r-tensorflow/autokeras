
#' Install Auto-Keras, Keras, and the TensorFlow backend
#'
#' Auto-Keras, Keras, and TensorFlow will be installed into an "r-tensorflow"
#' virtual or conda environment. Note that "virtualenv" is not available on
#' Windows (as this isn't supported by TensorFlow).
#'
# @inheritParams tensorflow::install_tensorflow
#' @inheritParams keras::install_keras
#'
#' @param version Version of Auto-Keras to install. Specify "default" to install
#'   the latest release. Otherwise specify an alternate version (e.g. "0.3.5").
#'   The default value is "0.3.7" as it is the latest tested version.
#'
#' @param keras Keras version to install. Specify "default" to install
#'   the latest release. Otherwise specify an alternate version (e.g. "2.2.2").
#'
#' @section GPU Installation:
#'
#' Keras and TensorFlow can be configured to run on either CPUs or GPUs. The CPU
#' version is much easier to install and configure so is the best starting place
#' especially when you are first learning how to use Keras. Here's the guidance
#' on CPU vs. GPU versions from the TensorFlow website:
#'
#' - *TensorFlow with CPU support only*. If your system does not have a NVIDIA®
#' GPU, you must install this version. Note that this version of TensorFlow is
#' typically much easier to install, so even if you have an NVIDIA GPU, we
#' recommend installing this version first.
#'
#' - *TensorFlow with GPU support*. TensorFlow programs typically run
#' significantly faster on a GPU than on a CPU. Therefore, if your system has a
#' NVIDIA® GPU meeting all prerequisites and you need to run
#' performance-critical applications, you should ultimately install this
#' version.
#'
#' To install the GPU version:
#'
#' 1) Ensure that you have met all installation prerequisites including
#'    installation of the CUDA and cuDNN libraries as described in
#'    [TensorFlow GPU Prerequistes](https://tensorflow.rstudio.com/installation_gpu.html#prerequisites).
#'
#' 2) Pass `tensorflow = "gpu"` to `install_autokeras()`. For example:
#'
#'     ```
#'       install_autokeras(tensorflow="gpu")
#'     ````
#'
#' @section Windows Installation:
#'
#' The only supported installation method on Windows is "conda". This means that
#' you should install Anaconda 3.x for Windows prior to installing Keras.
#'
#' @section Custom Installation:
#'
#' Installing Keras and TensorFlow using `install_autokeras()` isn't required
#' to use the Keras R package. You can do a custom installation of Keras (and
#' desired backend) as described on the
#' [Keras website](https://keras.io/#installation) and the Keras R package will
#' find and use that version.
#'
#' See the documentation on [custom installations](https://tensorflow.rstudio.com/installation.html#custom-installation)
#' for additional information on how version of Keras and TensorFlow are located
#' by the Keras package.
#'
#' @section Additional Packages:
#'
#' If you wish to add additional PyPI packages to your Keras / TensorFlow
#' environment you can either specify the packages in the `extra_packages`
#' argument of `install_autokeras()`,  or alternatively install them into an
#' existing environment using the [reticulate::py_install()] function.
#'
#' @examples
#' \dontrun{
#'
#' # default installation
#' library("autokeras")
#' install_autokeras()
#'
#' # install using a conda environment (default is virtualenv)
#' install_autokeras(method="conda")
#'
#' # install with GPU version of TensorFlow
#' # (NOTE: only do this if you have an NVIDIA GPU + CUDA!)
#' install_autokeras(tensorflow="gpu")
#'
#' # install a specific version of TensorFlow
#' install_autokeras(tensorflow="1.2.1")
#' install_autokeras(tensorflow="1.2.1-gpu")
#'
#' # install a specific version of Keras and TensorFlow
#' install_autokeras(keras="2.2.2", tensorflow="1.2.1")
#'
#' }
#'
#' @importFrom keras install_keras
#' @importFrom reticulate py_discover_config
#'
#' @export
install_autokeras <- function(method=c("auto", "virtualenv", "conda"),
                              conda="auto",
                              version="0.3.7", # R autokeras built with this ver
                              keras="default",
                              tensorflow="default",
                              extra_packages=NULL) {

  py_version <- package_version(reticulate::py_discover_config()$version);
  if (length(py_version) != 1 || py_version != 3.6)
    stop("Currently, Auto-Keras is only compatible with: Python 3.6.",
         "Please install this Python version and re-run install_autokeras()",
         call.=FALSE)

  # resolve version
  if (identical(version, "default"))
    version <- ""
  else
    version <- paste0("==", version)

  # perform the install
  install_keras(method=method,
                conda=conda,
                version=keras,
                tensorflow=tensorflow,
                extra_packages=c(paste0("autokeras", version), extra_packages))
}
