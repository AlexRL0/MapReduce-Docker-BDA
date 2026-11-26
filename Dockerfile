FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
 apt-get install -y openjdk-11-jdk ssh rsync python3 curl nano procps && \
 rm -rf /var/lib/apt/lists/*

ENV HADOOP_VERSION=3.3.6 \
 HADOOP_HOME=/opt/hadoop \
 JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 \
 HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
 PATH=/opt/hadoop/bin:/opt/hadoop/sbin:$PATH

RUN curl -L -o /tmp/hadoop.tgz \
 https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
 tar -xzf /tmp/hadoop.tgz -C /opt && \
 mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop && rm /tmp/hadoop.tgz

WORKDIR /root
COPY conf/ ${HADOOP_CONF_DIR}/
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

RUN mkdir -p /root/.ssh && \
 ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa && \
 cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
 
RUN mkdir -p /hadoop_tmp/hdfs/namenode /hadoop_tmp/hdfs/datanode
EXPOSE 9870 8088
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]