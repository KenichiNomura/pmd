#!/bin/sh

pgfortran -Mcuda cublas.f90 -o cublas -l cublas
