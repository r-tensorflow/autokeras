R interface to Auto-Keras
================

[Auto-Keras](https://autokeras.com/) is an open source software library for automated machine learning (AutoML). It is developed by [DATA Lab](http://faculty.cs.tamu.edu/xiahu/index.html) at Texas A&M University and community contributors. The ultimate goal of AutoML is to provide easily accessible deep learning tools to domain experts with limited data science or machine learning background. Auto-Keras provides functions to automatically search for architecture and hyperparameters of deep learning models.

Dependencies
------------

-   have fully functional [Auto-Keras](https://autokeras.com/), i.e. TensorFlow, Keras, etc.

-   have fully functional TensorFlow and Keras R libraries.

Installation
------------

AutoKeras is currently only available as a GitHub package. To install it run the following from an R console:

``` r
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("jcrodriguez1989/autokeras")
```

Examples
--------

### CIFAR-10 dataset

``` r
library("autokeras")
library("keras")

# Get CIFAR-10 dataset, but not preprocessing needed
cifar10 <- dataset_cifar10()

c(x_train, y_train) %<-% cifar10$train
c(x_test, y_test) %<-% cifar10$test
```

``` r
# Create an image classifier, and train different models for 30 minutes
clf <- model_image_classifier(verbose=TRUE, augment=FALSE) %>% 
  fit(x_train, y_train, time_limit=30*60)

# Get the best trained model
# For some bug, this needs to be killed (Ctrl+c), but fits the model anyways
clf %>% final_fit(x_train, y_train, x_test, y_test, retrain=TRUE)

# And use it to evaluate, predict
clf %>% evaluate(x_test, y_test)
clf %>% predict(x_test[1:10,,,])

# get the Keras model to work with the Keras R library
get_keras_model(clf)
```
