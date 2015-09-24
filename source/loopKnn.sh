#!/bin/bash
        for i in 230, 270, 300, 350, 400, 500
        do
           echo running for k = $i
           java -cp weka.jar weka.classifiers.lazy.IBk -K $i -W 0 -t mashable.arff -A "weka.core.neighboursearch.LinearNNSearch -A \"weka.core.EuclideanDistance -R first-last\"" >> knn230-210_mashable.txt 
        done
