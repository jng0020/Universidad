#!bin/bash
CLASSPATH=./bin:./lib/*
export CLASSPATH
javadoc -doclet com.sun.tools.doclets.doccheck.DocCheck -docletpath ./lib/doccheck.jar -d doccheck -sourcepath ./src -subpackages juego -encoding WINDOWS-1252
