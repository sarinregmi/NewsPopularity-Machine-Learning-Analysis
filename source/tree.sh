#!/bin/bash
java -cp weka.jar weka.classifiers.trees.J48 -t $1 -C $2 -M $3