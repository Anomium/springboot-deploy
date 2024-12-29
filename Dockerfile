FROM gradle:8.5-jdk21 AS build

WORKDIR /opt/app
COPY . .
RUN gradle clean build -x test

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /opt/app
COPY --from=build /opt/app/build/libs/*.jar app.jar
ENV PORT=8081
EXPOSE $PORT
ENTRYPOINT ["java", "-jar", "-Xmx1024M", "-Dserver.port=${PORT}", "app.jar"]