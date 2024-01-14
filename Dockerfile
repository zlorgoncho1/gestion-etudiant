FROM ubuntu:20.04

# Set environment variables for non-interactive shell
ENV DEBIAN_FRONTEND=noninteractive

# Update and upgrade the Ubuntu packages
RUN apt-get update && apt-get upgrade -y

# Install wget if it's not already included
RUN apt-get install -y wget unzip

# Download and extract JDK
RUN wget https://download.java.net/java/GA/jdk21.0.1/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-21.0.1_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-21.0.1_linux-x64_bin.tar.gz && \
    mkdir -p /usr/local/ && \
    mv jdk-21.0.1 /usr/local/

# Download and extact gradle
RUN wget https://services.gradle.org/distributions/gradle-8.5-bin.zip && \
    unzip -d /usr/local/ gradle-8.5-bin.zip

RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz && \
    tar -xvf apache-tomcat-9.0.84.tar.gz && \
    mkdir -p /usr/local/ && \
    mv apache-tomcat-9.0.84 /usr/local/

# Removing Gradle Bin File And JDK tar File
RUN rm gradle-8.5-bin.zip
RUN rm openjdk-21.0.1_linux-x64_bin.tar.gz
RUN rm apache-tomcat-9.0.84.tar.gz

RUN groupadd tomcat && useradd -s /bin/false -g tomcat -d /usr/local/apache-tomcat-9.0.84 tomcat
RUN chown -RH tomcat: /usr/local/apache-tomcat-9.0.84 && chmod +x /usr/local/apache-tomcat-9.0.84/bin/*.sh

# Set JAVA_HOME, GRADLE_HOME and add Java, Gradle to PATH
ENV JAVA_HOME=/usr/local/jdk-21.0.1
ENV GRADLE_HOME=/usr/local/gradle-8.5
ENV CATALINA_HOME=/usr/local/apache-tomcat-9.0.84

ENV PATH=$JAVA_HOME/bin:$GRADLE_HOME/bin:$PATH
ENV APP_FOLDER /home/app

RUN echo 'export JAVA_OPTS="$JAVA_OPTS -DDATABASE_USER=$DATABASE_USER -DDATABASE_PASSWORD=$DATABASE_PASSWORD -DDATABASE_SERVER_PORT=$DATABASE_SERVER_PORT"' > $CATALINA_HOME/bin/setenv.sh

WORKDIR $APP_FOLDER

COPY . $APP_FOLDER/

# Expose port 8080
EXPOSE 8080

# Run Tomcat as the 'tomcat' user
USER tomcat

# Set the default command to run on boot
CMD ./gradlew clean build && \
    cp app/build/libs/app.war $CATALINA_HOME/webapps/ && \
    /usr/local/apache-tomcat-9.0.84/bin/catalina.sh run
