BusVis: Visualization of the Konstanz Bus Transportation System
===============================================================

<div align="center"><img src="BusVis.png" height="600"></div>
<br/>

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

The ReproZip package is available [here](https://osf.io/kaxse/) (69 MB).

How to Reproduce
----------------

You will need a local X server for display. For instance, if you are running on Mac OS X, you can use [XQuartz](https://www.xquartz.org/); if you are running on Windows, take a look at [Xming](https://sourceforge.net/projects/xming/). More information on packing and unpacking graphical applications can be found [here](http://reprozip.readthedocs.io/en/latest/faq.html#can-reprozip-pack-graphical-tools).

You can then run BusVis as following:

    $ reprounzip vagrant setup BusVis.rpz busvis/
    $ reprounzip vagrant run --enable-x11 busvis/

Please note that X11 forwarding through SSH is slow, so it may be slow to interact with the application. However, we have plans to fix this issue. For more information, see [ViDA-NYU/reprozip#189](https://github.com/ViDA-NYU/reprozip/issues/189).

Packing From Our Demo VM
------------------------

If you are using our demo VM image, first, make sure you uncomment the ``vb.gui = true`` line in the [Vagrantfile](../Vagrantfile) before running ``vagrant up``. Log in to the machine (username: ``vagrant``, password: ``vagrant``) and run the following:

    $ startxfce4

Then, open the Terminal and run:

    $ cd reprozip-examples/bus-vis/BusVis/target/
    $ java -jar BusVis-0.5.1-desktop-jar-with-dependencies.jar
