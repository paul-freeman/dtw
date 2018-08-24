"""Build DTW library"""
from setuptools import setup, Extension
import numpy

setup(
    name='dtw',
    version='1.0.0',
    author='Paul Freeman',
    author_email='paul.freeman.cs@gmail.com',
    license='MIT License',
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Cython',
        'Topic :: Scientific/Engineering :: Physics'
    ],
    url='https://github.com/paul-freeman/dtw',
    description=('An implementation of the Dynamic Time Warping algorithm'),
    ext_modules=[
        Extension("dtw", ["dtw.pyx"],
                  include_dirs=[numpy.get_include()])
    ]
)
