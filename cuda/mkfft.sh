#!/bin/sh

pgfortran -Mcuda cufft.f90 ffttest.f90 -o cufft -l cufft
