Creating and Testing a SVM Classifier
=====================================

This example creates and tests a SVM classifier for [the digits dataset](http://archive.ics.uci.edu/ml/datasets/Pen-Based+Recognition+of+Handwritten+Digits) using [scikit-learn](http://scikit-learn.org/).

Original Experiment
-------------------

The original experiment is composed by four steps:

1. [Data Collection](01_getdata.py): the digits dataset is collected using scikit-learn and the data is split into training and test sets.
2. [Classification](02_classifier.py): a SVM classifier is created using the training set.
3. [Prediction](03_predict.py): the SVM classifier is tested using the test set.
4. [Confusion Matrix](04_confusion_matrix.py): a confusion matrix is created using the prediction data.

The confusion matrix is written to standard output as:

    Confusion matrix:
    [[87  0  0  0  1  0  0  0  0  0]
     [ 0 88  1  0  0  0  0  0  1  1]
     [ 0  0 85  1  0  0  0  0  0  0]
     [ 0  0  0 79  0  3  0  4  5  0]
     [ 0  0  0  0 88  0  0  0  0  4]
     [ 0  0  0  0  0 88  1  0  0  2]
     [ 0  1  0  0  0  0 90  0  0  0]
     [ 0  0  0  0  0  1  0 88  0  0]
     [ 0  0  0  0  0  0  0  0 88  0]
     [ 0  0  0  1  0  1  0  0  0 90]]

To run this experiment without ReproZip, you will need to install [scikit-learn](http://scikit-learn.org/) and run each script with Python, in the aforementioned order.

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/) (X MB).

How to Reproduce
----------------

The experiment can be reproduced as follows:
