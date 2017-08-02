FROM ring2016/centos6-jdk7-maven3

### MAVEN ###
WORKDIR /programs
ADD apache-maven-3.5.0.tar.gz /programs

### Compile ###
ADD pom.xml /pom.xml
RUN cd / && /programs/apache-maven-3.5.0/bin/mvn dependency:go-offline



WORKDIR /code
ADD pom.xml /code/pom.xml
ADD src /code/src
ADD server.xml /usr/local/tomcat6/conf/server.xml
RUN ["/programs/apache-maven-3.5.0/bin/mvn", "package"]

### install ###
RUN cp target/demo.war $CATALINA_HOME/webapps/

### run ###
EXPOSE 80
CMD ["catalina.sh", "run"]

