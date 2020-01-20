# $ docker run -ti ubuntu:18.04 /bin/bash
FROM ubuntu:18.04

# install all python and R dependencies
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt --assume-yes install python3.6 python3-pip r-base
RUN pip3 install --upgrade pip
RUN hash -r pip
RUN ln -s /usr/bin/python3.6 /usr/bin/python

RUN R -e "\
  options(repos = \
    list(CRAN = 'http://mirror.las.iastate.edu/CRAN/')); \
  install.packages('remotes'); \
  install.packages('reticulate'); \
  reticulate::install_miniconda(); \
  remotes::install_github('r-tensorflow/autokeras'); \
  autokeras::install_autokeras()"

# create a working dir
RUN mkdir /autokeras_files
WORKDIR /autokeras_files

# $ docker build . -t jcrodriguez1989/r-autokeras:1.0.0
