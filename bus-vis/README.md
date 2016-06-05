BusVis: Visualization of the Konstanz Bus Transportation System
===============================================================

<img src="BusVis.png" height="600">

BusVis is a Java application that shows the fastest time and path between two bus stops in the city of Konstanz. You can see the time from a station to every other update in real time as buses come and go. The application consists of a visualization panel with which users can interact.

Original Experiment
-------------------

BusVis was written by Josua Krause and is available on GitHub under the terms of the MIT license: [JosuaKrause/BusVis](https://github.com/JosuaKrause/BusVis).

The application can be run as following:

    $ mvn clean package                                         ## building
    $ cd target/
    $ java -jar BusVis-0.5.1-desktop-jar-with-dependencies.jar  ## running

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/s/euxfsq1gjy9khehoakg2g9s4iu13plnd) (69 MB).

How to Reproduce
----------------

You will need a local X server for display. For instance, if you are running on Mac OS X, you can use [XQuartz](https://www.xquartz.org/); if you are running on Windows, take a look at [Xming](https://sourceforge.net/projects/xming/). More information on packing and unpacking graphical applications can be found [here](http://reprozip.readthedocs.io/en/latest/faq.html#can-reprozip-pack-graphical-tools).

You can then run BusVis as following:

    $ reprounzip vagrant setup BusVis.rpz busvis/
    $ reprounzip vagrant run --enable-x11 busvis/

Please note that X11 forwarding through SSH is slow, so it may be slow to interact with the application. However, we have plans to fix this issue. For more information, see [ViDA-NYU/reprozip#189](https://github.com/ViDA-NYU/reprozip/issues/189).