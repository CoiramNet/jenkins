FROM scratch
ADD alpine/alpine-minirootfs-3.17.1-x86_64.tar.gz / 

# Upgrade and update
RUN apk update --no-cache &&\
    apk upgrade --no-cache

#Let's install some tools and clean the cache
RUN apk add --no-cache wget &&\
    apk add --no-cache bash &&\
    apk add --no-cache ttf-dejavu &&\
    rm -rf /var/cache/apk/* 
     
#Create Jenkins user and working directory
RUN mkdir /DevOps &&\
    adduser -D -H jenkins
    
#Install OpenJava as per Jenkins requirements
RUN apk add --no-cache openjdk11 &&\
    rm -rf /var/cache/apk/*
 
#Download Jenkins
RUN wget https://get.jenkins.io/war-stable/2.361.1/jenkins.war -O /DevOps/jenkins.war

#Copy entrypoint shell file   
COPY scripts/entrypoint.sh /DevOps/entrypoint.sh
RUN chmod +x /DevOps/entrypoint.sh
RUN sed -i 's/\r//g' /DevOps/entrypoint.sh

#Expose port, volume and launch entrypoint
VOLUME ["/DevOps/Jenkins"]
EXPOSE 8080
ENTRYPOINT ["/DevOps/entrypoint.sh"]
