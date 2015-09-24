#!/bin/bash
	echo data-taken-away,train-error,cv-error,time-taken >> mashable_adaboost_filtered.csv
        for i in 10 20 30 40 50 60 70 80 90
        do
           echo removing percentage of data $i
           FILTER="weka.filters.unsupervised.instance.RemovePercentage -P $i"
           java -cp weka.jar weka.classifiers.meta.FilteredClassifier -t $1 -F "$FILTER" -W weka.classifiers.meta.AdaBoostM1 -- -P 100 -S 1 -I 100 -W weka.classifiers.trees.J48 -- -C 0.1 -M 200 > boost_sarin.txt 
            variable=$(grep Incorrectly boost_sarin.txt | awk '{printf "%s,", $5} END {print ""}')
            vtime=$(grep 'Time taken to build model' boost_sarin.txt | awk '{printf "%s,", $6} END {print ""}')
           echo $i $variable $vtime >>mashable_adaboost_filtered.csv       
        done