############### this version was working fine with render! ###############
# Build stage
#
FROM maven:3.8.7 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -Pprod -DskipTests

#
# Package stage
#
FROM eclipse-temurin:18-jre
WORKDIR /app
COPY --from=build /app/target/mastermind-webapp-0.0.1-SNAPSHOT.jar mastermind-webapp-docker.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "mastermind-webapp-docker.jar"]

# to use the docker file, first we need to build the docker image
# run in terminal 'docker build -t spring-boot-render .'
# then we can run the docker image
# run in terminal 'docker run -p 8080:8080 spring-boot-render'
