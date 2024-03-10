FROM maven:3.9.6 as build
WORKDIR /java
COPY . .
RUN mvn clean install

FROM openjdk:8
WORKDIR /app
EXPOSE 8080
COPY --from=build /java/target/spring-boot-docker.jar spring-boot-docker.jar
ENTRYPOINT ["java","-jar","/spring-boot-docker.jar"]
