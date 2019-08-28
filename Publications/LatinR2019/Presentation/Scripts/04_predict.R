library("autokeras")
library("keras")

if (Sys.info()[["user"]] == "jcrodriguez") {
  setwd("~/mytmp/emoji_ds/")
}

## load model

uncat_arr <- readRDS("uncat_arr.rds")
clf <- import_autokeras_model("emoji_ds.pkl")

specs <- data.frame(do.call(rbind, strsplit(rownames(uncat_arr), ":")))
colnames(specs) <- c("category", "name")
table(specs$category)
table(specs$name)

clf %>% predict(uncat_arr[specs$name == "mate-drink",,,]) %>% table() %>% prop.table()

clf %>% predict(uncat_arr[specs$name == "axe",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "beverage-box",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "briefs",,,]) %>% table() %>% prop.table() %>% sort(decreasing = TRUE)
clf %>% predict(uncat_arr[specs$name == "butter",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "deaf-person",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "diving-mask",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "falafel",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "flamingo",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "garlic",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "guide-dog",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "kneeling-person",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "mate-drink",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "mechanical-arm",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "mechanical-leg",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "onion",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "orangutan",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "oyster",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "probing-cane",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "sari",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "shorts",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "sloth",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "standing-person",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "stethoscope",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "waffle",,,]) %>% table() %>% prop.table()
clf %>% predict(uncat_arr[specs$name == "yawning-face",,,]) %>% table() %>% prop.table()
