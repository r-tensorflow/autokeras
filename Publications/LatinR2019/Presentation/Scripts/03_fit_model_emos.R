et.seed(8818)

## load data

`🏷s` <- readRDS("labels.rds")
`ℹⓂ️gs_🅰️rr` <- readRDS("imgs_arr.rds")

`t🇪🇸t_🆔✖s` <- sample(seq_len(nrow(`🏷s`)), round(nrow(`ℹⓂ️gs_🅰️rr`) * .2))
`✖_🚂` <- `ℹⓂ️gs_🅰️rr`[-`t🇪🇸t_🆔✖s`, , , ]
`y_🚂` <- `🏷s`[-`t🇪🇸t_🆔✖s`, "Category"]
`✖_t🇪🇸t` <- `ℹⓂ️gs_🅰️rr`[`t🇪🇸t_🆔✖s`, , , ]
`y_t🇪🇸t` <- `🏷s`[`t🇪🇸t_🆔✖s`, "Category"]
dim(`✖_🚂`)
head(`y_🚂`)

## fit autokeras model

# Create an image classifier, and train for one hour
`🆑f` <- model_image_classifier(verbose = TRUE, augment = FALSE) %>%
  fit(`✖_🚂`, `y_🚂`, time_limit = 1 * 60 * 60)

# Evaluate
`🆑f` %>% evaluate(`✖_t🇪🇸t`, `y_t🇪🇸t`)

# Re-train the best trained model with all the available data
`🆑f` %>%
  final_fit(
    `✖_🚂`, `y_🚂`, `✖_t🇪🇸t`, `y_t🇪🇸t`,
    retrain = TRUE, time_limit = 20 * 60
  )
