library("ggplot2")
library("reshape2")
# library("autokeras")
# clf <- import_autokeras_model("data/emoji_ds.pkl")

emojify <- function(imgs) {
  imgs <- gsub("\\.png", "", basename(imgs))
  act_specs <- specs[specs$name %in% imgs, ]
  # act_preds <- predict(clf, uncat_arr[specs$name %in% imgs, , , ])
  act_preds <- preds[sub(".*:", "", names(preds)) %in% imgs]
  act_preds <- factor(act_preds, levels = categories)
  res <- do.call(rbind, by(act_preds, as.character(act_specs$name), table))
  res <- prop.table(res, 1) * 100
  res[imgs, ]
}

categories <- c(
  "activity", "flags", "food-drink", "nature", "objects",
  "people", "symbols", "travel-places"
)

imgs <- dir("data/emojis/Google/", full.names = TRUE)
# uncat_arr <- readRDS("data/uncat_arr.rds")
preds <- readRDS("data/preds.rds")
specs <- data.frame(do.call(rbind, strsplit(names(preds), ":")))
colnames(specs) <- c("category", "name")

sample_imgs <- function(imgs, n = 4) {
  sample(imgs, n)
}

categ_plot <- function(vals) {
  vals <- melt(vals)
  vals$category <- rownames(vals)
  ggplot(vals) +
    geom_bar(aes(x = category, y = value, fill = category),
             stat = "identity") +
    lims(y = c(0, 100)) +
    theme(axis.text.x = element_text(angle = 20, hjust = 1))
}
