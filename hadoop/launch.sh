#!/usr/bin/env zsh

# re-format namenode
yes | $HADOOP_HOME/bin/hdfs namenode -format

# start hdfs
$HADOOP_HOME/bin/hdfs --daemon start namenode
$HADOOP_HOME/bin/hdfs --daemon start secondarynamenode
$HADOOP_HOME/bin/hdfs --daemon start datanode
$HADOOP_HOME/bin/yarn --daemon start resourcemanager
$HADOOP_HOME/bin/yarn --daemon start nodemanager
$HADOOP_HOME/bin/mapred --daemon start historyserver
