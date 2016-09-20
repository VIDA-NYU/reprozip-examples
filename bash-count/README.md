Bash Script
===========

This is a very simple example where a [bash script](count.sh) is used to count the number of pages of an [input file](textfile).

Original Experiment
-------------------

The original example can be run as follows:

    $ chmod +x count.sh
    $ ./count.sh

which returns the following output:

    5

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/s/wq4e4mohg4wn719tef1csrad5x0b1kwh) (1.6 MB).

How to Reproduce
----------------

The example can be reproduced as follows:

    $ reprounzip vagrant setup bash-count.rpz bash-count/
    $ reprounzip vagrant run bash-count/

This example, although very simple, has many dependencies, as can be seen from its [provenance graph](graph.png). To generate the same graph:

    $ reprounzip graph bash-count.dot bash-count.rpz
    $ dot -Tpng bash-count.dot -o graph.png
