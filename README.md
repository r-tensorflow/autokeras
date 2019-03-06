R interface to Auto-Keras
================

[Auto-Keras](https://autokeras.com/) is an open source software library for automated machine learning (AutoML). It is developed by [DATA Lab](http://faculty.cs.tamu.edu/xiahu/index.html) at Texas A&M University and community contributors. The ultimate goal of AutoML is to provide easily accessible deep learning tools to domain experts with limited data science or machine learning background. Auto-Keras provides functions to automatically search for architecture and hyperparameters of deep learning models.

Dependencies
------------

-   [Auto-Keras](https://autokeras.com/) requires Python 3.6 .

Installation
------------

AutoKeras is currently only available as a GitHub package. To install it run the following from an R console:

``` r
if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("jcrodriguez1989/autokeras")
```

Then, use the `install_autokeras()` function to install TensorFlow:

``` r
library("autokeras")
install_autokeras()
```

Docker
------

Auto-Keras R package has a configured Docker image. Steps to run it:

From a bash console:

``` bash
docker pull jcrodriguez1989/r-autokeras:0.1.0
docker run -it jcrodriguez1989/r-autokeras:0.1.0 /bin/bash
```

Once inside the Docker image, you can run the example R script:

``` bash
Rscript cifar10_example.R
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
# Create an image classifier, and train different models for 3 minutes
clf <- model_image_classifier(verbose=TRUE, augment=FALSE) %>% 
  fit(x_train, y_train, time_limit=3*60)
```

``` r
# Get the best trained model
# For some bug, this needs to be killed (Ctrl+c), but fits the model anyways
clf %>% final_fit(x_train, y_train, x_test, y_test, retrain=TRUE, time_limit=30)
```

``` r
# And use it to evaluate, predict
clf %>% evaluate(x_test, y_test)
```

    ## [1] 0.322

``` r
clf %>% predict(x_test[1:10,,,])
```

    ##  [1] 6 8 9 8 6 5 7 6 5 9

``` r
# get the Keras model to work with the Keras R library
get_keras_model(clf)
```

    ## Model
    ## ___________________________________________________________________________
    ## Layer (type)                     Output Shape                  Param #     
    ## ===========================================================================
    ## input_1 (InputLayer)             (None, 32, 32, 3)             0           
    ## ___________________________________________________________________________
    ## activation_1 (Activation)        (None, 32, 32, 3)             0           
    ## ___________________________________________________________________________
    ## batch_normalization_1 (BatchNorm (None, 32, 32, 3)             12          
    ## ___________________________________________________________________________
    ## conv2d_1 (Conv2D)                (None, 32, 32, 64)            1792        
    ## ___________________________________________________________________________
    ## max_pooling2d_1 (MaxPooling2D)   (None, 16, 16, 64)            0           
    ## ___________________________________________________________________________
    ## activation_2 (Activation)        (None, 16, 16, 64)            0           
    ## ___________________________________________________________________________
    ## batch_normalization_2 (BatchNorm (None, 16, 16, 64)            256         
    ## ___________________________________________________________________________
    ## conv2d_2 (Conv2D)                (None, 16, 16, 64)            36928       
    ## ___________________________________________________________________________
    ## max_pooling2d_2 (MaxPooling2D)   (None, 8, 8, 64)              0           
    ## ___________________________________________________________________________
    ## activation_3 (Activation)        (None, 8, 8, 64)              0           
    ## ___________________________________________________________________________
    ## batch_normalization_3 (BatchNorm (None, 8, 8, 64)              256         
    ## ___________________________________________________________________________
    ## conv2d_3 (Conv2D)                (None, 8, 8, 64)              36928       
    ## ___________________________________________________________________________
    ## max_pooling2d_3 (MaxPooling2D)   (None, 4, 4, 64)              0           
    ## ___________________________________________________________________________
    ## global_average_pooling2d_1 (Glob (None, 64)                    0           
    ## ___________________________________________________________________________
    ## dropout_1 (Dropout)              (None, 64)                    0           
    ## ___________________________________________________________________________
    ## dense_1 (Dense)                  (None, 64)                    4160        
    ## ___________________________________________________________________________
    ## activation_4 (Activation)        (None, 64)                    0           
    ## ___________________________________________________________________________
    ## dense_2 (Dense)                  (None, 10)                    650         
    ## ===========================================================================
    ## Total params: 80,982
    ## Trainable params: 80,720
    ## Non-trainable params: 262
    ## ___________________________________________________________________________
