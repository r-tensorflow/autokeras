context("can_create_objects")

test_that("can create image classifier", {
  expect_is(
    model_image_classifier(),
    "AutokerasModel"
  )
})

test_that("can create image regressor", {
  expect_is(
    model_image_regressor(),
    "AutokerasModel"
  )
})

test_that("can create text classifier", {
  expect_is(
    model_text_classifier(),
    "AutokerasModel"
  )
})

test_that("can create text regressor", {
  expect_is(
    model_text_regressor(),
    "AutokerasModel"
  )
})

test_that("can create structured data classifier", {
  expect_is(
    model_structured_data_classifier(),
    "AutokerasModel"
  )
})

test_that("can create structured data regressor", {
  expect_is(
    model_structured_data_regressor(),
    "AutokerasModel"
  )
})
