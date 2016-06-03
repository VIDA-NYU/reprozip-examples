BusVis: Visualization of the Konstanz bus transportation system
===============================================================

This example is a Java visualization that shows the fastest time and path between two bus stops in the city of Konstanz. You can see the time from a station to every other update in real time as buses come and go.

Original Experiment
-------------------

This application was written by Josua Krause and is available on GitHub under the terms of the MIT license: [JosuaKrause/BusVis](https://github.com/JosuaKrause/BusVis).

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/s/euxfsq1gjy9khehoakg2g9s4iu13plnd) (69 MB).

How to Reproduce
----------------

You will need a local X server for display. You can then run the experiment as follow:

    $ reprounzip vagrant setup BusVis.rpz busvis/
    $ reprounzip vagrant run --enable-x11 busvis/
