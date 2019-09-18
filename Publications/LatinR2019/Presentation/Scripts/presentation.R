if (Sys.info()[["user"]] == "jcrodriguez") {
  setwd("~/Dropbox/R/autokeras/Publications/LatinR2019/Presentation/Scripts/")
}

delayedAssign("i_thanks_yihui", {
  rstudioapi::setDocumentContents("")
  fit_model_code <- readLines(
    "03_fit_model.R", encoding = "UTF-8", warn = FALSE)
  xfun::rstudio_type(fit_model_code[1:23], pause = function() 0.01)
  Sys.sleep(2)
  xfun::rstudio_type(fit_model_code[23:29], pause = function() 0.01)
  Sys.sleep(2.5)
  xfun::rstudio_type(fit_model_code[29:32], pause = function() 0.01)
  Sys.sleep(1)
  xfun::rstudio_type(fit_model_code[32:39], pause = function() 0.01)
})

delayedAssign("s", {
  fit_model_code <- readLines(
    "03_fit_model_emos.R", encoding = "UTF-8", warn = FALSE)
  xfun::rstudio_type(fit_model_code, pause = function() 0.01)
})

