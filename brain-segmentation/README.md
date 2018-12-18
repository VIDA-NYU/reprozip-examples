Brain Segmentation
==================

<div align="center"><img src="median_otsu.png" height="300"></div>
<br/>

This example shows how to extract brain information and mask from an input b0 image using [dipy](http://nipy.org/dipy/), a diffusion imaging analysis package. This is based on an [example](http://nipy.org/dipy/examples_built/brain_extraction_dwi.html#example-brain-extraction-dwi) available at dipy's gallery.

Original Experiment
-------------------

The original experiment is composed by a single script named [`brain-segmentation.py`](brain-segmentation.py), which consumes and segments the brain data that comes from a 1.5 tesla Siemens MRI (`siemens_scil_b0`).

To run this experiment without ReproZip, you will need to first install [dipy](http://nipy.org/dipy/).

ReproZip Package
----------------

The ReproZip package is available [here](https://osf.io/8cx46/download) (46.5 MB).

How to Reproduce
----------------

The experiment can be reproduced as follows:

    $ reprounzip vagrant setup brain-segmentation.rpz brain-segmentation/
    $ reprounzip vagrant run --enable-x11 brain-segmentation/

The output image with the results can be retrieved as follows:

    $ reprounzip vagrant download brain-segmentation/ median_otsu.png

You can also perform the same prediction with an alternate input data (`ge_scil_b0`) as follows:

    $ reprounzip vagrant upload brain-segmentation/ ge_scil_b0:siemens_scil_b0
    $ reprounzip vagrant run --enable-x11 brain-segmentation/

And finally download the results as follows:

    $ reprounzip vagrant download brain-segmentation/ median_otsu.png

Packing From Our Demo VM
------------------------

If you are using our demo VM image, you can run the following:

    $ vagrant ssh
    $ cd reprozip-examples/brain-segmentation/
    $ python brain-segmentation.py
