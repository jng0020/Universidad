#!/bin/bash

CLASSPATH=./bin:./lib/*
javac -cp $CLASSPATH -d ./bin -encoding WINDOWS-1252 ./src/*/*/*

