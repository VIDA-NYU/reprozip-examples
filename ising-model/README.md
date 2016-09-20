Critical Temperature for the Ising Model
========================================

This experiment is a typical simulation in statistical physics, consisting of large scale Monte Carlo simulations followed by an involved statistical analysis of the results. The simulation estimates the critical temperature where the Ising model on the square lattice becomes magnetic to be Tc/J = 2.26934(6) using a finite size scaling analysis of the crossing points of Binder cumulants.

Original Experiment
-------------------

The original experiment is described in the following paper:

[*A Model Project for Reproducible Papers: Critical Temperature for the Ising Model on a Square Lattice. Michele Dolfi, Jan Gukelberger, Andreas Hehn, J. Imriska, K. Pakrouski, T. F. Rønnow, Matthias Troyer, I. N. Zintchenko, Fernando Chirigati, Juliana Freire, and Dennis Shasha. CoRR abs/1401.2000 (2014)*](http://arxiv.org/abs/1401.2000)

A [virtual machine](http://archive.comp-phys.org/provenance_challenge/provenance_machine.ova) is provided by the authors to reproduce all the figures and results. Instructions on how to use the virtual machine are available in the paper.

ReproZip Package
----------------

The ReproZip package is available [here](https://nyu.box.com/s/03umg9hclll9qkq0omxcf6r0vrf4eg3m) (24.9 MB). This package reproduces the single-threaded version of the experiment for the following system sizes: 8, 16, 32, and 64.

How to Reproduce
----------------

The experiment can be reproduced as follows:

    $ reprounzip vagrant setup --memory 1024 ising_model.rpz ising_model/
    $ reprounzip vagrant run ising_model/ simulate_small

The figures of the [paper](http://arxiv.org/abs/1401.2000) can be reproduced as follows.

*Figure 1*:

    $ reprounzip vagrant run ising_model/ susceptibility
    $ reprounzip vagrant download ising_model/ fig_susceptibility.pdf

*Figure 2*:

    $ reprounzip vagrant run ising_model/ binder_cumulant
    $ reprounzip vagrant download ising_model/ fig_binderU2_vs_T.pdf

*Figure 3*:

    $ reprounzip vagrant run ising_model/ binder_cumulant
    $ reprounzip vagrant download ising_model/ fig_binder_crossings_vs_L.pdf

*Figure 4*:

    $ reprounzip vagrant run ising_model/ binder_collapse
    $ reprounzip vagrant download ising_model/ fig_binder_collapse_vs_T.pdf
