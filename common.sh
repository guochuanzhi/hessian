#!/bin/bash

redEcho() {
    if [ -c /dev/stdout ] ; then
        # if stdout is console, turn on color output.
        echo -ne "\033[1;31m"
        echo -n "$@"
        echo -e "\033[0m"
    else
        echo "$@"
    fi
}

runCmd() {
    redEcho "$@"
    "$@"
}

cleanAndInstall() {
    mvn clean install -Dmaven.test.skip && mvn test-compile &&
    mvn dependency:copy-dependencies -DincludeScope=provided &&
    mvn dependency:copy-dependencies -DincludeScope=test
}

version=`grep '<version>.*</version>' pom.xml | awk -F'</?version>' 'NR==1{print $2}'`
aid=`grep '<artifactId>.*</artifactId>' pom.xml | awk -F'</?artifactId>' 'NR==2{print $2}'`