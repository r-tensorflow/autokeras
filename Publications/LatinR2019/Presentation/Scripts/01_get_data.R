library("rvest")

if (Sys.info()[["user"]] == "jcrodriguez") {
  setwd("~/mytmp/emoji_ds/")
}

## get emojis categories

emojipedia_url <- "https://emojipedia.org/"
categories <- read_html(emojipedia_url) %>%
  html_node(xpath = "/html/body/div/div[2]/div[1]/ul") %>%
  html_children()

categories <- do.call(rbind, lapply(categories, function(act_cat) {
  categ_node <- act_cat %>% html_children()
  c(
    html_text(categ_node),
    html_attr(categ_node, "href")
  )
}))

## download each category emojis

# get each emoji url
categ_emo_urls <- lapply(seq_len(nrow(categories)), function(i) {
  act_categ <- categories[i, ]
  act_categ_url <- paste0(emojipedia_url, act_categ[[2]])
  act_categ_emos <- read_html(act_categ_url) %>%
    html_node(xpath = "/html/body/div[2]/div[1]/ul") %>%
    html_children()

  unlist(lapply(act_categ_emos, function(act_emo) {
    act_emo %>%
      html_children() %>%
      html_attr("href")
  }))
})

invisible(lapply(seq_along(categ_emo_urls), function(i) {
  categ_save_dir <- gsub("/", "", categories[i, 2])
  dir.create(categ_save_dir, showWarnings = FALSE)
  act_urls <- categ_emo_urls[[i]]
  print(c(categ_save_dir, length(act_urls)))
  lapply(act_urls, function(act_url) {
    act_emo_url <- paste0(emojipedia_url, act_url)
    act_emo_vers <- read_html(act_emo_url) %>%
      html_node("section.vendor-list") %>%
      html_nodes("div.vendor-container.vendor-rollout-target")

    lapply(act_emo_vers, function(act_emo) {
      vers <- act_emo %>%
        html_node("div.vendor-info") %>%
        html_text() %>%
        trimws()
      ver_save_dir <- paste0(categ_save_dir, "/", gsub(" ", "_", vers))
      dir.create(ver_save_dir, showWarnings = FALSE)
      img <- act_emo %>%
        html_node("div.vendor-image") %>%
        html_node("img") %>%
        html_attr("src")
      save_file <- paste0(
        ver_save_dir, "/", gsub("/", "", act_url), ".",
        gsub(".*\\.", "", basename(img))
      )
      if (!file.exists(save_file)) {
        download.file(img, save_file, quiet = TRUE)
      }
    })
  })
}))

## download uncategorized emojis

uncateg_url <- paste0(emojipedia_url, "unicode-12.0")
uncateg_emos <- read_html(uncateg_url) %>%
  html_node(xpath = "/html/body/div[2]/div[1]/article/ul[1]") %>%
  html_children()

uncateg_emo_urls <- unlist(lapply(uncateg_emos, function(act_emo) {
  act_emo %>%
    html_children() %>%
    html_attr("href")
}))

uncateg_save_dir <- "uncategorized"
dir.create(uncateg_save_dir, showWarnings = FALSE)
invisible(lapply(uncateg_emo_urls, function(act_url) {
  act_emo_url <- paste0(emojipedia_url, act_url)
  act_emo_vers <- read_html(act_emo_url) %>%
    html_node("section.vendor-list") %>%
    html_nodes("div.vendor-container.vendor-rollout-target")

  lapply(act_emo_vers, function(act_emo) {
    vers <- act_emo %>%
      html_node("div.vendor-info") %>%
      html_text() %>%
      trimws()
    ver_save_dir <- paste0(uncateg_save_dir, "/", gsub(" ", "_", vers))
    dir.create(ver_save_dir, showWarnings = FALSE)
    img <- act_emo %>%
      html_node("div.vendor-image") %>%
      html_node("img") %>%
      html_attr("src")
    save_file <- paste0(
      ver_save_dir, "/", gsub("/", "", act_url), ".",
      gsub(".*\\.", "", basename(img))
    )
    if (!file.exists(save_file)) {
      download.file(img, save_file, quiet = TRUE)
    }
  })
}))

## explore downloaded data

library("dplyr")

n_emojis <- do.call(rbind, lapply(dir(), function(act_categ) {
  act_categ_vers <- dir(act_categ)
  data.frame(
    Version = act_categ_vers,
    Category = act_categ,
    Emojis = sapply(act_categ_vers, function(act_vers) {
      length(dir(paste0(act_categ, "/", act_vers)))
    })
  )
}))

n_emojis <- n_emojis %>% filter(Category != "uncategorized")
n_emojis %>%
  group_by(Version) %>%
  summarise(nemo = sum(Emojis)) %>%
  arrange(nemo)
