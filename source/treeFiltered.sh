#!/bin/bash
	echo Data Taken Away,Train error, CV error >> mashable_tree-filter.csv
        for i in 10 20 30 40 50 60 70 80 90
        do
           echo removing percentage of data $i
           FILTER="weka.filters.unsupervised.instance.RemovePercentage -P $i"
           java -cp weka.jar weka.classifiers.meta.FilteredClassifier -t mashable.arff -F "$FILTER" -W weka.classifiers.trees.J48 -- -C 0.1 -M 50  >  tree_mashable.txt 
        	variable=$(grep Incorrectly tree_mashable.txt | awk '{printf "%s,", $5} END {print ""}')
           echo $i,$variable >> mashable_tree-filter.csv       
        done