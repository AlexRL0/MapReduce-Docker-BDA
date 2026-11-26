#!/usr/bin/env bash
set -e
service ssh start
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export HADOOP_HOME=/opt/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

if [ ! -d "/hadoop_tmp/hdfs/namenode/current" ]; then
 echo "Formateando NameNode..."
 hdfs namenode -format -force
fi
/usr/local/bin/start-services.sh
hdfs dfs -mkdir -p /user/root
tail -f /dev/null