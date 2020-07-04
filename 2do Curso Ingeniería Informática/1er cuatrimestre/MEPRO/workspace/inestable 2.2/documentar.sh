#!/bin/bash
CLASSPATH=./bin:./lib/*
javadoc -cp $CLASSPATH -d ./doc -charset UTF-8 -author -encoding WINDOWS-1252 ./src/*/*/*
exec firefox ./doc/index.html 2> /dev/null 


