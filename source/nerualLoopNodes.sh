#!/bin/bash
echo Inner Nodes,Train Error,CV Error, Train Time >> Neural_nodes.csv
        for i in 10 15 20 25
        do
           echo running for k = $i
           java -cp weka.jar weka.classifiers.functions.MultilayerPerceptron -t mashable.arff -L 0.3 -M 0.2 -N 500 -V 0 -S 0 -E 20 -H $i -R > neural_125-500_epoch_mashable.txt
           variable=$(grep Incorrectly neural_125-500_epoch_mashable.txt | awk '{printf "%s,", $5} END {print ""}')
           vtime=$(grep 'Time taken to build model' neural_125-500_epoch_mashable.txt | awk '{printf "%s,", $6} END {print ""}')
           echo $i,$variable,$vtime >> Neural_nodes.csv
        done

