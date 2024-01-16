#!/bin/sh

cd /metersphere/lib
ls | sort > /metersphere_files.txt

cd /task-runner/lib
ls | sort > /task-runner_files.txt

cd /result-hub/lib
ls | sort > /result-hub_files.txt
# standalone
comm -12 /metersphere_files.txt /task-runner_files.txt | comm -12 - /result-hub_files.txt > /tmp/comm.txt

mkdir -p /standalone/lib

for file in $(cat /tmp/comm.txt)
do
     mv /metersphere/lib/$file /standalone/lib
     rm -rf /task-runner/lib/$file
     rm -rf /result-hub/lib/$file
done


# 重新计算
cd /metersphere/lib
ls | sort > /metersphere_files.txt

cd /result-hub/lib
ls | sort > /result-hub_files.txt
# server
comm -12 /metersphere_files.txt /result-hub_files.txt > /tmp/server.txt

mkdir -p /server/lib

for file in $(cat /tmp/server.txt)
do
     mv /metersphere/lib/$file /server/lib
     rm -rf /result-hub/lib/$file
done


# 重新计算
cd /metersphere/lib
ls | sort > /metersphere_files.txt

cd /task-runner/lib
ls | sort > /task-runner_files.txt
# server
comm -12 /metersphere_files.txt /task-runner_files.txt > /tmp/runner.txt

mkdir -p /runner/lib

for file in $(cat /tmp/runner.txt)
do
     mv /metersphere/lib/$file /runner/lib
     rm -rf /task-runner/lib/$file
done