context("can_create_objects")

test_that("can create image_classifier", {
  expect_is(
    model_image_classifier(),
    "AutokerasModel"
  )
})

test_that("can create image_regressor", {
  expect_is(
    model_image_regressor(),
    "AutokerasModel"
  )
})

test_that("can create text_classifier", {
  expect_is(
    model_text_classifier(),
    "AutokerasModel"
  )
})

test_that("can create text_regressor", {
  expect_is(
    model_text_regressor(),
    "AutokerasModel"
  )
})
