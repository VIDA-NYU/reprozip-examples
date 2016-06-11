MongoDB-VLS
===========

<div align="center"><img src="mongodb-vls.png" height="500"></div>
<br/>

[MongoDB-VLS](https://github.com/ViDA-NYU/mongodb-vls) is a prototype implementation of VLS in MongoDB. VLS, or *Virtual Lightweight Snapshots*, is a mechanism, presented at [ICDE 2016](http://bigdata.poly.edu/~fchirigati/papers/chirigati-icde2016.pdf), that enables consistent analytics without blocking incoming updates in NoSQL stores.

Implementation
--------------

MongoDB-VLS implementation and experiments are available [here](https://github.com/ViDA-NYU/mongodb-vls). 

ReproZip Package
----------------

ReproZip packages for the plots of the [ICDE paper](http://bigdata.poly.edu/~fchirigati/papers/chirigati-icde2016.pdf) are available [here](https://github.com/ViDA-NYU/mongodb-vls/tree/master/experiments/reprozip).

How to Reproduce
----------------

For instance, to reproduce Figure 7:

    $ reprounzip vagrant setup query_execution_time.rpz query_execution_time/
    $ reprounzip vagrant run query_execution_time/
    $ reprounzip vagrant download query_execution_time/ scan_duration.png
    $ reprounzip vagrant download query_execution_time/ scan_duration_updates.png

<div align="center"><img src="https://github.com/ViDA-NYU/mongodb-vls/blob/master/experiments/plots/results/scan_duration.png" height="400">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/ViDA-NYU/mongodb-vls/blob/master/experiments/plots/results/scan_duration_updates.png" height="400"></div>
<br/>