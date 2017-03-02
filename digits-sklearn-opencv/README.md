Predicting the Values of Hand-Written Digits
============================================

<div align="center"><img src="output.jpg" height="300"></div>
<br/>

This example creates a SVM classifier for [the digits dataset](http://archive.ics.uci.edu/ml/datasets/Pen-Based+Recognition+of+Handwritten+Digits) using [scikit-learn](http://scikit-learn.org/), and predicts the values of hand-written digits of an [input image](photo.jpg).

Original Experiment
-------------------

The original experiment is composed by two steps:

1. [Classification](generateClassifier.py): the SVM classifier is created.
1. [Prediction](performRecognition.py): the values of hand-written digits from the input file are predicted and recognized ([output.jpg](output.jpg)).

To run this experiment without ReproZip, you will need to first install [scikit-learn](http://scikit-learn.org/) and [OpenCV 3.0.0](http://opencv.org/), and then run each script with Python, in the aforementioned order.

ReproZip Package
----------------

The ReproZip package is available [here](https://osf.io/5ztp2/) (79.0 MB).

How to Reproduce
----------------

The experiment can be reproduced as follows:

    $ reprounzip vagrant setup digitRecognition.rpz digit-recognition/
    $ reprounzip vagrant run digit-recognition/ classification
    $ reprounzip vagrant run digit-recognition/ prediction

The input image with the predictions can be retrieved as follows:

    $ reprounzip vagrant download digit-recognition/ output.jpg

You can also perform the same prediction with an [alternate input file](photo_2.jpg) as follows:

    $ reprounzip vagrant upload digit-recognition/ photo_2.jpg:photo.jpg
    $ reprounzip vagrant run digit-recognition/ prediction

And finally download the results as follows:

    $ reprounzip vagrant download digit-recognition/ output.jpg

Packing From Our Demo VM
------------------------

If you are using our demo VM image, you can run the following:

    $ vagrant ssh
    $ workon digits-sklearn-opencv
    $ cd reprozip-examples/digits-sklearn-opencv/
    $ python generateClassifier.py
    $ python performRecognition.py
