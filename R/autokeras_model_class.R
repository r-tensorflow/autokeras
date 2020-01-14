#' Autokeras model class representation
#'
#' @importFrom methods setClass
#'
setClass("AutokerasModel",
  slots = c(
    model = "ANY"
    # model="python.builtin.object" # not working
  )
)
