#!/bin/sh

export JAVA_CLASSPATH=/task-runner:/opt/jmeter/lib/ext/*:/task-runner/lib/*:/standalone/lib/*
export JAVA_MAIN_CLASS=io.metersphere.runner.Application
export JAVA_OPTIONS="-Dfile.encoding=utf-8 -Djava.awt.headless=true --add-opens java.base/jdk.internal.loader=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.io=ALL-UNNAMED"
export MS_VERSION=`cat /tmp/MS_VERSION`

sh /deployments/run-java.sh

