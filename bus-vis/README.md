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

You can run BusVis as follows:

    $ reprounzip vagrant setup --use-gui BusVis.rpz busvis/
    $ reprounzip vagrant run busvis/

If you have a local X server (for example you are using Linux, or have installed [xquartz](https://www.xquartz.org/) for Mac or [Xming](https://sourceforge.net/projects/xming/) for Windows) you can use that instead of the VM's display via the following commands (note that rendering might be a bit slower):

    $ reprounzip docker setup BusVis busvis/
    $ reprounzip docker run --enable-x11 busvis/

More information on packing and unpacking graphical applications can be found [here](http://reprozip.readthedocs.io/en/latest/faq.html#can-reprozip-pack-graphical-tools).

Packing From Our Demo VM
------------------------

If you are using our demo VM image, first, make sure you uncomment the ``v.gui = true`` line in the [Vagrantfile](../Vagrantfile) before running ``vagrant up``. Log in to the machine (username: ``vagrant``, password: ``vagrant``) and run the following:

    $ startxfce4

Then, open the Terminal and run:

    $ cd reprozip-examples/bus-vis/BusVis/target/
    $ java -jar BusVis-0.5.1-desktop-jar-with-dependencies.jar
