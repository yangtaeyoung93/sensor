FROM adoptopenjdk:8-jdk-hotspot AS builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew build -x test

ADD build/libs/sensor-0.0.1-SNAPSHOT.war sensor.war
ENTRYPOINT [ "java", "-jar", "/sensor.war" ]
EXPOSE 7942