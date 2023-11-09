#!/bin/sh

export JAVA_CLASSPATH=/task-runner:/opt/jmeter/lib/ext/*:/task-runner/lib/*:/standalone/lib/*
export JAVA_MAIN_CLASS=io.metersphere.Application
export JAVA_OPTIONS="-Dfile.encoding=utf-8 -Djava.awt.headless=true --add-opens java.base/jdk.internal.loader=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED"

node_exporter --path.procfs=/host/proc --path.sysfs=/host/sys &
sed -i "s/:101:/:${MS_DOCKER_GID:-101}:/g" /etc/group

sh /deployments/run-java.sh

