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

The ReproZip package is available [here](https://nyu.box.com/shared/static/2101vi9wb0md3vo3kra1xjft3unnznsu.rpz) (20.0 MB).

How to Reproduce
----------------

All the steps of the experiment can be reproduced as follows:

    $ reprounzip vagrant setup digits_sklearn.rpz digits/
    $ reprounzip vagrant run digits/

Optionally, you can also reproduce each step individually:

    $ reprounzip vagrant run digits/ get_data
    $ reprounzip vagrant run digits/ build_classifier
    $ reprounzip vagrant run digits/ predict
    $ reprounzip vagrant run digits/ evaluate

**_The VisTrails Workflow_**

The digits-sklearn experiment is a great example of how you can easily extend the original pipeline to further analyze the results, or even reuse it in your own research.

Recall that ReproZip automatically generates a [VisTrails](http://www.vistrails.org/) workflow for the experiment given that [reprounzip-vistrails](http://reprozip.readthedocs.org/en/stable/vistrails.html) is installed. This workflow is located under `digits/vistrails.vt`.

You can replace it with the one we provide [here](digits_sklearn.vt) to see how the workflow can be extended to enhance the reproducibility experience. After opening it, replace the value of the *directory* parameter (from module *Directory*) with the full path of `digits/`, and then run the workflow by pressing *Execute*. You will see that the workflow was extended to provide visualization for the predictions and the confusion matrix.
