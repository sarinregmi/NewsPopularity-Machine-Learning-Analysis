#!/bin/bash
	echo data-taken-away,train-error,cv-error,time-taken >> mashable_neural_filtered.csv
        for i in 10 20 30 40 50 60 70 80 90
        do
           echo removing percentage of data $i
           FILTER="weka.filters.unsupervised.instance.RemovePercentage -P $i"
           java -cp weka.jar weka.classifiers.meta.FilteredClassifier -t mashable.arff -F "$FILTER" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S 0 -E 20 -H 40 > test_sarin.txt 
            variable=$(grep Incorrectly test_sarin.txt | awk '{printf "%s,", $5} END {print ""}')
            vtime=$(grep 'Time taken to build model' test_sarin.txt | awk '{printf "%s,", $6} END {print ""}')
           echo $i,$variable, $vtime >> mashable_neural_filtered.csv       
        done

