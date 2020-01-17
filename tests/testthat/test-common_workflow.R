context("common_workflow")

# basically checks that there is no error in a normal workflow.
test_that("AutoKeras for images workflow", {
  skip("Frozens the execution.")
  library("keras")

  # load mnist dataset
  mnist <- dataset_mnist()
  c(x_train, y_train) %<-% mnist$train
  c(x_test, y_test) %<-% mnist$test

  n <- 200
  # first 100 values for train
  x_train <- x_train[seq_len(n), , ]
  y_train <- y_train[seq_len(n)]
  # and 20 for test
  x_test <- x_test[seq_len(n / 10), , ]
  y_test <- y_test[seq_len(n / 10)]

  # as the input is the same, randomly get classifier or regressor
  if (sample(c(TRUE, FALSE), 1)) {
    cat("\nImage Classifier\n")
    clf <- model_image_classifier(max_trials = 2)
  } else {
    cat("\nImage Regressor\n")
    clf <- model_image_regressor(max_trials = 2)
  }

  # fit for 2 minutes
  clf %>% fit(x_train, y_train, epochs = 2)

  # And use it to evaluate, predict
  clf %>% evaluate(x_test, y_test)
  clf %>% predict(x_test)
})
