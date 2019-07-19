# Dynamic Time Warping

This package provides a Cython implementation of [the Dynamic Time Warping
algorithm](https://en.wikipedia.org/wiki/Dynamic_time_warping).

This algorithm should easily handle data with lengths up to 10,000 (or more),
although memory requirements will eventually impose an upper bound. It has
been demonstrated in our testing that this implementation significantly
outperforms a pure Python implementation (no surprise there) but is also
significantly faster than using [the dtw package in
R](http://dtw.r-forge.r-project.org/) when calling it from Python.

This algorithm is hard-coded to use the `symmetric2` step pattern - the
default step pattern used by the R algorithm. But feel free to fork and
modify if you need another step pattern, the code is very short!

## Installation

Being a compiled extension package, we are doing our best to provide compiled
versions via ``conda``.

Simply run:

    conda install dtw -c freemapa

If ``conda`` does not have a package for your architecture (or you are not
using ``conda``), you can certainly compile this package yourself.

Simply download the source code and run:

    python setup.py install

This will require NumPy and Cython (both common packages).

## Calling the algorithm

To call the algorithm, simply import ``dtw`` in Python. The algorithm takes
two arrays of data (*template* and *query*) as inputs and returns four
values: *distance*, *alignment1*, *alignment2*, and *costs_matrix*.

The algorithm is actually quite short, so please give it a quick read if you
wish to know more about how it works.
