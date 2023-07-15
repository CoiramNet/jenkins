#!/bin/sh

# Let's start Jenkins
chown -R jenkins.jenkins /DevOps
export JENKINS_HOME=/DevOps/Jenkins
export ITEM_ROOTDIR=/DevOps/jobs
JENKINS_JAVA_OPTIONS="-Xmx1024m -XX:MaxPermSize=512m -Djava.awt.headless=true"
export TMP=/tmp
export TEMP=/tmp
su -p -s /bin/bash jenkins -c "java -jar /DevOps/jenkins.war --httpPort=8080" 



 