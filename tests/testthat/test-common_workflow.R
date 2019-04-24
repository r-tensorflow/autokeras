context("common_workflow")

# basically checks that there is no error in a normal workflow.
test_that("Auto-Keras for images workflow", {
  library("keras")

  # load mnist dataset
  mnist <- dataset_mnist()
  c(x_train, y_train) %<-% mnist$train
  c(x_test, y_test) %<-% mnist$test

  # first 100 values for train
  x_train <- x_train[1:100,,]
  y_train <- y_train[1:100]
  # and 20 for test
  x_test  <- x_test[1:20,,]
  y_test <- y_test[1:20];

  # as the input is the same, randomly get classifier or regressor
  if (sample(c(TRUE, FALSE), 1)) {
    cat("\nImage Classifier\n")
    clf <- model_image_classifier(verbose=FALSE)
  } else {
    cat("\nImage Regressor\n")
    clf <- model_image_regressor(verbose=FALSE)
  }

  # fit for 2 minutes
  clf %>% fit(x_train, y_train, time_limit=2*60)

  # get final fit
  clf %>% final_fit(x_train, y_train, x_test, y_test)

  # And use it to evaluate, predict
  clf %>% evaluate(x_test, y_test)
  clf %>% predict(x_test)

  # get the Keras model to work with the Keras R library
  get_keras_model(clf)

  ak_file <- paste0(tempfile(), ".pkl")
  was_saved <- clf %>% export_autokeras_model(ak_file)
  if (was_saved) {
    clf2 <- import_autokeras_model(ak_file)
    expect_equal(
      clf %>% predict(x_test),
      clf2 %>% predict(x_test)
    )
  }
})
