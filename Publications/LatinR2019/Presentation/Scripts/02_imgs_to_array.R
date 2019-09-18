library("keras")

if (Sys.info()[["user"]] == "jcrodriguez") {
  setwd("~/mytmp/emoji_ds/")
}

categories <- list.dirs(recursive = FALSE, full.names = FALSE)

## get max image size

# act_categ_vers <- dir(categories[[1]])
# sizes <- do.call(rbind, lapply(act_categ_vers, function(act_vers) {
#   act_img <- dir(paste0(categories[[1]], "/", act_vers), full.names = TRUE)[[1]]
#   act_img %>%
#     keras::image_load() %>%
#     keras::image_to_array() %>%
#     dim()
# }))
# c(height, width) %<-% apply(sizes, 2, max)[1:2]
c(height, width) %<-% c(32, 32) # use 32x32 as in CIFAR

## images to arrays

categories <- categories[categories != "uncategorized"]
imgs_arrs <- lapply(categories, function(act_categ) {
  act_categ_vers <- dir(act_categ)
  res <- lapply(act_categ_vers, function(act_vers) {
    imgs <- dir(paste0(act_categ, "/", act_vers), full.names = TRUE)
    lapply(imgs, function(act_img) {
      res <- act_img %>%
        image_load() %>%
        image_to_array() %>%
        image_array_resize(height, width)
      apply(res, 1:3, as.integer)
    })
  })
  names(res) <- act_categ_vers
  res
})
names(imgs_arrs) <- categories

# saveRDS(imgs_arrs, file = "imgs_arrs.rds")
imgs_arrs <- readRDS("imgs_arrs.rds")

library("abind")

imgs_arr <- abind(lapply(imgs_arrs, function(i) {
  abind(lapply(i, function(j) {
    abind(j, along = 0)
  }), along = 1)
}), along = 1)
dim(imgs_arr)

# saveRDS(imgs_arr, file = "imgs_arr.rds")

## get the emojis categories

labels <- do.call(rbind, lapply(names(imgs_arrs), function(i) {
  cbind(i, unlist(lapply(names(imgs_arrs[[i]]), function(j) {
    rep(j, length(imgs_arrs[[i]][[j]]))
  })))
}))
colnames(labels) <- c("Category", "Version")

# saveRDS(labels, file = "labels.rds")

## uncategorized emojis to arrays

act_categ_vers <- dir("uncategorized")
uncat_arrs <- lapply(act_categ_vers, function(act_vers) {
  imgs <- dir(paste0("uncategorized", "/", act_vers), full.names = TRUE)
  lapply(imgs, function(act_img) {
    res <- act_img %>%
      image_load() %>%
      image_to_array() %>%
      image_array_resize(height, width)
    apply(res, 1:3, as.integer)
  })
})
names(uncat_arrs) <- act_categ_vers

uncat_arr <- abind(lapply(uncat_arrs, function(j) {
  abind(j, along = 0)
}), along = 1)
dim(uncat_arr)

rownames(uncat_arr) <- unlist(lapply(act_categ_vers, function(act_vers)
  paste0(
    act_vers, ":",
    sub("\\..*", "", dir(paste0("uncategorized", "/", act_vers)))
  )))

# saveRDS(uncat_arr, file = "uncat_arr.rds")
