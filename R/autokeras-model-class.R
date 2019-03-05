
#' Autokeras model class representation
#'
setClass("AutokerasModel",
         slots=c(
           model="ANY"
           # model="python.builtin.object" # not working
         )
)
