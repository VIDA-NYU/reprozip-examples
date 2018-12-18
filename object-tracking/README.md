Multiple Object Tracking (MOT)
==============================

<div align="center"><img src="mot.png" height="300"></div>
<br/>

The main goal of this experiment is to track the movement of multiple objects from an input video.

Original Experiment
-------------------

The original experiment is available [here](https://github.com/BinalModi/Computer-Vision-Projects/tree/master/MultipleObjectTracking). Users first select an object in the input video, and then they press either the space or the enter key so that the program can automatically track the movement of this object as the video plays.

To run this experiment without ReproZip, you will first need to install [OpenCV 2.4.9.1](https://opencv.org/) and the following [requirements](requirements.txt):

* [opencv-contrib-python](https://pypi.org/project/opencv-contrib-python/)

Then, run the following script:

    $ python multipleObjectTracking.py


ReproZip Package
----------------

The ReproZip package is available [here](https://osf.io/jxhgu/download) (52 MB).

How to Reproduce
----------------

You can reproduce the application as follows:

    $ reprounzip vagrant setup --use-gui object-tracking.rpz object-tracking/
    $ reprounzip vagrant run object-tracking/

If you have a local X server (for example, if you are using Linux, or have installed [xquartz](https://www.xquartz.org/) for Mac or [Xming](https://sourceforge.net/projects/xming/) for Windows), you can use that instead of the VM's display via the following commands (note that rendering might be a bit slower):

    $ reprounzip docker setup object-tracking.rpz object-tracking/
    $ reprounzip docker run --enable-x11 object-tracking/

 More information on packing and unpacking graphical applications can be found [here](https://docs.reprozip.org/en/1.0.x/faq.html#can-reprozip-pack-graphical-tools).

Packing From Our Demo VM
------------------------

If you are using our demo VM image, first, make sure you uncomment the ``v.gui = true`` line in the [Vagrantfile](../Vagrantfile) before running ``vagrant up``. Log in to the machine (username: ``vagrant``, password: ``vagrant``) and run the following:

    $ startxfce4

Then, open the Terminal and run:

    $ vagrant ssh
    $ workon object-tracking
    $ cd reprozip-examples/object-tracking/
    $ python multipleObjectTracking.py
