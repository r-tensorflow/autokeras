library("ggplot2")
library("reshape2")
library("autokeras")
library("keras")

# import trained autokeras model
clf <- import_autokeras_model("data/emoji_ds.pkl")

# transform an image file to an array
# img_path: path to the image
img_2_array <- function(img_path) {
  ## images to arrays
  c(height, width) %<-% c(32, 32) # use 32x32 as in CIFAR
  res <- img_path %>%
    image_load() %>%
    image_to_array() %>%
    image_array_resize(height, width)
  apply(res, 1:3, as.integer)
}

categories <- c(
  "activity", "flags", "food-drink", "nature", "objects",
  "people", "symbols", "travel-places"
)

# classifies the image with the autokeras previously trained model
# img_path: path to the image
emojify <- function(img_path) {
  if (img_path == "") {
    return(list(src = ""))
  }

  img_arr <- img_2_array(img_path)
  dim(img_arr) <- c(1, 32, 32, 3)

  pred <- clf %>% predict(img_arr)
  # an image represents the category
  list(src = paste0("data/categories/", pred, ".png"), alt = pred)
}
