#!/bin/bash
echo iterations,training-error,cv-error >> boost_poly.csv
for i in 100 150 200 250 300 350 400
	do
		echo running for iterations = $i
		java -cp weka.jar weka.classifiers.meta.AdaBoostM1 -t mashable.arff -P 100 -S 1 -I $i -W weka.classifiers.trees.J48 -- -C 0.1 -M 200 > adaboost100-400_iter_mashable.txt
		variable=$(grep Incorrectly adaboost100-400_iter_mashable.txt | awk '{printf "%s,", $5} END {print ""}')
		echo $i,$variable >> boost_poly.csv
	done