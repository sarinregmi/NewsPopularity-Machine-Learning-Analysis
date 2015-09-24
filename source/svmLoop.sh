#!/bin/bash
		echo cost-value,train-error,cv-error >> svm_mash-cost_lin.csv
		echo cost-value,train-error,cv-error >> svm_mash-cost_poly.csv
        for i in 1 5 10 15 20 40 80 100 150 200 250  500 750 1000 1500 2000 2500
        do
           echo running for cost = $i 
           
           java -cp weka.jar:libsvm.jar weka.classifiers.functions.LibSVM -t mashable.arff -S 0 -K 0 -D 3 -G 0.0 -R 0.0 -N 0.5 -M 40.0 -C $i -E 0.0010 -P 0.1 -seed 1 > svm-test_mash_lin.txt 
           variable=$(grep Incorrectly svm-test_mash_lin.txt | awk '{printf "%s,", $5} END {print ""}')
           echo $i,$variable >> svm_mash-cost_lin.csv
           
           java -cp weka.jar:libsvm.jar weka.classifiers.functions.LibSVM -t mashable.arff -S 0 -K 1 -D 2 -G 0.0 -R 0.0 -N 0.5 -M 40.0 -C $i -E 0.0010 -P 0.1 -seed 1 > svm-test_mash_poly.txt 
           variables=$(grep Incorrectly svm-test_mash_poly.txt | awk '{printf "%s,", $5} END {print ""}')
           echo $i,$variables >> svm_mash-cost_poly.csv
        done