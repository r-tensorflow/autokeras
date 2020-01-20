library("autokeras")
library("keras")

if (Sys.info()[["user"]] == "jcrodriguez") {
  setwd("~/mytmp/emoji_ds/")
}

## load model

uncat_arr <- readRDS("uncat_arr.rds")
clf <- import_autokeras_model("emoji_ds.pkl")

preds <- clf %>% predict(uncat_arr)
names(preds) <- rownames(uncat_arr)

# saveRDS(preds, file = "preds.rds")
