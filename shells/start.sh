#!/bin/sh

sh /shells/metersphere.sh & 
sh /shells/task-runner.sh & 
sh /shells/result-hub.sh  &
sh /shells/daemon.sh      &


wait




