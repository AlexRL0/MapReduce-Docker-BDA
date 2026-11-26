#!/usr/bin/env bash
export HADOOP_HOME=/opt/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
start-dfs.sh
start-yarn.sh
jps
