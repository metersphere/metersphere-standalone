#!/bin/sh

export JAVA_CLASSPATH=/metersphere:/opt/jmeter/lib/ext/*:/metersphere/lib/*:/standalone/lib/*:/server/lib/*:/runner/lib/*
export JAVA_MAIN_CLASS=io.metersphere.Application
export JAVA_OPTIONS="-Dfile.encoding=utf-8 -Djava.awt.headless=true --add-opens java.base/jdk.internal.loader=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.io=ALL-UNNAMED"
export MS_VERSION=`cat /tmp/MS_VERSION`

sh /deployments/run-java.sh


