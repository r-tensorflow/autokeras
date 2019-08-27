library("autokeras")
library("keras")

if (Sys.info()[["user"]] == "jcrodriguez") {
  setwd("~/mytmp/emoji_ds/")
}

## load data

set.seed(8818)
labels <- readRDS("labels.rds")
imgs_arr <- readRDS("imgs_arr.rds")

test_idxs <- sample(seq_len(nrow(labels)), round(nrow(imgs_arr) * .2))
x_train <- imgs_arr[-test_idxs, , , ]
y_train <- labels[-test_idxs, "Category"]
x_test <- imgs_arr[test_idxs, , , ]
y_test <- labels[test_idxs, "Category"]

rm(list = c("labels", "imgs_arr"))

## fit autokeras model

# Create an image classifier, and train different models
clf <- model_image_classifier(verbose = TRUE, augment = FALSE) %>%
  fit(x_train, y_train, time_limit = 30 * 60)

# Get the best trained model
clf %>%
  final_fit(
    x_train, y_train, x_test, y_test,
    retrain = TRUE, time_limit = 15 * 60
  )

## test model

# And use it to evaluate, predict
clf %>% evaluate(x_test, y_test)

## [1] 0.7334981

clf %>% predict(x_test[1:10, , , ])

# get the Keras model to work with the Keras R library
get_keras_model(clf)

# Model
# Model: "model_1"
# ___________________________________________________________________
# Layer (type)          Output Shape  Param # Connected to
# ===================================================================
# input_1 (InputLayer)  [(None, 32, 3 0
# ___________________________________________________________________
# activation_1 (Activat (None, 32, 32 0       input_1[0][0]
# ___________________________________________________________________
# batch_normalization_1 (None, 32, 32 12      activation_1[0][0]
# ___________________________________________________________________
# max_pooling2d_4 (MaxP (None, 16, 16 0       batch_normalization_1[0
# ___________________________________________________________________
# conv2d_1 (Conv2D)     (None, 32, 32 1792    batch_normalization_1[0
# ___________________________________________________________________
# activation_5 (Activat (None, 16, 16 0       max_pooling2d_4[0][0]
# ___________________________________________________________________
# max_pooling2d_1 (MaxP (None, 16, 16 0       conv2d_1[0][0]
# ___________________________________________________________________
# conv2d_4 (Conv2D)     (None, 16, 16 256     activation_5[0][0]
# ___________________________________________________________________
# add_1 (Add)           (None, 16, 16 0       max_pooling2d_1[0][0]
#                                             conv2d_4[0][0]
# ___________________________________________________________________
# activation_2 (Activat (None, 16, 16 0       add_1[0][0]
# ___________________________________________________________________
# batch_normalization_2 (None, 16, 16 256     activation_2[0][0]
# ___________________________________________________________________
# conv2d_6 (Conv2D)     (None, 16, 16 36928   batch_normalization_2[0
# ___________________________________________________________________
# conv2d_2 (Conv2D)     (None, 16, 16 73856   conv2d_6[0][0]
# ___________________________________________________________________
# max_pooling2d_2 (MaxP (None, 8, 8,  0       conv2d_2[0][0]
# ___________________________________________________________________
# activation_3 (Activat (None, 8, 8,  0       max_pooling2d_2[0][0]
# ___________________________________________________________________
# conv2d_5 (Conv2D)     (None, 8, 8,  147584  activation_3[0][0]
# ___________________________________________________________________
# batch_normalization_3 (None, 8, 8,  512     conv2d_5[0][0]
# ___________________________________________________________________
# conv2d_3 (Conv2D)     (None, 8, 8,  73792   batch_normalization_3[0
# ___________________________________________________________________
# max_pooling2d_3 (MaxP (None, 4, 4,  0       conv2d_3[0][0]
# ___________________________________________________________________
# global_average_poolin (None, 64)    0       max_pooling2d_3[0][0]
# ___________________________________________________________________
# dropout_1 (Dropout)   (None, 64)    0       global_average_pooling2
# ___________________________________________________________________
# dense_1 (Dense)       (None, 64)    4160    dropout_1[0][0]
# ___________________________________________________________________
# activation_4 (Activat (None, 64)    0       dense_1[0][0]
# ___________________________________________________________________
# dense_2 (Dense)       (None, 8)     520     activation_4[0][0]
# ===================================================================
# Total params: 339,668
# Trainable params: 339,278
# Non-trainable params: 390
# ___________________________________________________________________

## save models

clf %>% export_autokeras_model("ak_model.pkl")
clf %>% export_keras_model("ak_model.h5")
