#!/bin/bash
		echo cost-value,train-error,cv-error >> svm_cars-filtered_lin.csv
		echo cost-value,train-error,cv-error >> svm_cars-filtered_poly.csv
        for i in 10 20 30 40 50 60 70 80 90 
        do
           echo removing percentage of data $i 
           # java -cp weka.jar:libsvm.jar weka.classifiers.functions.LibSVM -t cars.arff -S 0 -K 0 -D 3 -G 0.0 -R 0.0 -N 0.5 -M 40.0 -C $i -E 0.0010 -P 0.1 -seed 1 > svm-test_cars.txt 
           #java -cp weka.jar:libsvm.jar weka.classifiers.functions.LibSVM -t cars.arff -S 0 -K 1 -D 2 -G 0.0 -R 0.0 -N 0.5 -M 40.0 -C $i -E 0.0010 -P 0.1 -seed 1 > svm-test_cars.txt 
           FILTER="weka.filters.unsupervised.instance.RemovePercentage -P $i"
           java -cp weka.jar:libsvm.jar weka.classifiers.meta.FilteredClassifier -t cars.arff -F "$FILTER" -W weka.classifiers.functions.LibSVM -- -S 0 -K 0 -D 3 -G 0.0 -R 0.0 -N 0.5 -M 40.0 -C 80 -E 0.0010 -P 0.1 -seed 1 > svm-filter_car_lin.txt
           variable=$(grep Incorrectly svm-filter_car_lin.txt | awk '{printf "%s,", $5} END {print ""}')
           echo $i,$variable >> svm_cars-filtered_lin.csv
           
           java -cp weka.jar:libsvm.jar weka.classifiers.meta.FilteredClassifier -t cars.arff -F "$FILTER" -W weka.classifiers.functions.LibSVM -- -S 0 -K 1 -D 2 -G 0.0 -R 0.0 -N 0.5 -M 40.0 -C 40 -E 0.0010 -P 0.1 -seed 1 > svm-filter_car_poly.txt
           variables=$(grep Incorrectly svm-filter_car_poly.txt | awk '{printf "%s,", $5} END {print ""}')
           echo $i,$variables >> svm_cars-filtered_poly.csv
        done