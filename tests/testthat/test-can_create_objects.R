context("can_create_objects")

test_that("can create image classifier", {
  skip_if(!reticulate::py_module_available("autokeras"))
  expect_is(
    model_image_classifier(),
    "AutokerasModel"
  )
})

test_that("can create image regressor", {
  skip_if(!reticulate::py_module_available("autokeras"))
  expect_is(
    model_image_regressor(),
    "AutokerasModel"
  )
})

test_that("can create text classifier", {
  skip_if(!reticulate::py_module_available("autokeras"))
  expect_is(
    model_text_classifier(),
    "AutokerasModel"
  )
})

test_that("can create text regressor", {
  skip_if(!reticulate::py_module_available("autokeras"))
  expect_is(
    model_text_regressor(),
    "AutokerasModel"
  )
})

test_that("can create structured data classifier", {
  skip_if(!reticulate::py_module_available("autokeras"))
  expect_is(
    model_structured_data_classifier(),
    "AutokerasModel"
  )
})

test_that("can create structured data regressor", {
  skip_if(!reticulate::py_module_available("autokeras"))
  expect_is(
    model_structured_data_regressor(),
    "AutokerasModel"
  )
})
