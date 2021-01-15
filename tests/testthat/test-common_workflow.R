context("common_workflow")

# basically checks that there is no error in a normal workflow.
test_that("AutoKeras for structured data workflow", {
  skip_if(!reticulate::py_module_available("autokeras"))
  library("keras")

  # use the iris dataset as an example
  set.seed(8818)
  # balanced sample 80% for training
  train_idxs <- unlist(by(seq_len(nrow(iris)), iris$Species, function(x) {
    sample(x, length(x) * .8)
  }))
  train_data <- iris[train_idxs, ]
  test_data <- iris[-train_idxs, ]

  colnames(iris)
  # Species will be the interest column to predict

  train_file <- paste0(tempdir(), "/iris_train.csv")
  write.csv(train_data, train_file, row.names = FALSE)

  # file to predict, cant have the response "Species" column
  test_file_to_predict <- paste0(tempdir(), "/iris_test_2_pred.csv")
  write.csv(test_data[, -5], test_file_to_predict, row.names = FALSE)

  test_file_to_eval <- paste0(tempdir(), "/iris_test_2_eval.csv")
  write.csv(test_data, test_file_to_eval, row.names = FALSE)

  # Initialize the structured data classifier

  clf <- model_structured_data_classifier(max_trials = 2) %>% # It tries 2 different models
    fit(train_file, "Species", epochs = 4)
  expect_is(clf, "AutokerasModel")

  # Predict with the best model
  (predicted_y <- clf %>% predict(test_file_to_predict))
  expect_is(clf, "AutokerasModel")
  expect_true(nrow(predicted_y) == nrow(test_data))

  # Evaluate the best model with testing data
  clf %>% evaluate(test_file_to_eval, "Species")
  expect_is(clf, "AutokerasModel")

  # Get the best trained Keras model, to work with the keras R library
  export_model(clf)
})
