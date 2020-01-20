if (Sys.info()[["user"]] == "jcrodriguez") {
  setwd("~/mytmp/emoji_ds/")
}

library("autokeras")
library("keras")

## load data

set.seed(8818)
labels <- readRDS("labels.rds")
imgs_arr <- readRDS("imgs_arr.rds")

test_idxs <- sample(seq_len(nrow(labels)), round(nrow(imgs_arr) * .2))
x_train <- imgs_arr[-test_idxs, , , ]
y_train <- labels[-test_idxs, "Category"]
x_test <- imgs_arr[test_idxs, , , ]
y_test <- labels[test_idxs, "Category"]
dim(x_train)
head(y_train)

rm(list = c("labels", "imgs_arr"))

## fit autokeras model

# Create an image classifier, and train for one hour
clf <- model_image_classifier(verbose = TRUE, augment = FALSE) %>%
  fit(x_train, y_train, time_limit = 1 * 60 * 60)

# Evaluate
clf %>% evaluate(x_test, y_test)

# Re-train the best trained model with all the available data
clf %>%
  final_fit(
    x_train, y_train, x_test, y_test,
    retrain = TRUE, time_limit = 20 * 60
  )

## save the model
clf %>% export_autokeras_model("emoji_ds.pkl")
