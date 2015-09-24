#!/bin/bash
	echo Data Taken Away,Train error, CV error >> mashable_knn-filter.csv
        for i in 10 20 30 40 50 60 70 80 90
        do
           echo removing percentage of data $i
           FILTER="weka.filters.unsupervised.instance.RemovePercentage -P $i"
           java -cp weka.jar weka.classifiers.meta.FilteredClassifier -t mashable.arff -F "$FILTER" -W weka.classifiers.lazy.IBk -- -K 70 -W 0 -A "weka.core.neighboursearch.LinearNNSearch -A \"weka.core.EuclideanDistance -R first-last\" -P" >  knn_mashable.txt 
        	variable=$(grep Incorrectly knn_mashable.txt | awk '{printf "%s,", $5} END {print ""}')
           echo $i,$variable >> mashable_knn-filter.csv       
        done