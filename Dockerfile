#FROM eclipse-temurin:21-jre-alpine
#WORKDIR /dev-company
#COPY build/libs/*.jar app.jar
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "app.jar"]



FROM eclipse-temurin:21-jdk-alpine as BUILDER
WORKDIR /dev-company
COPY gradle ./gradle
COPY src ./src
COPY gradlew build.gradle settings.gradle ./
RUN --mount=type=cache,target=/root/.gradle ./gradlew --no-daemon -i clean bootJar

FROM eclipse-temurin:21-jre-alpine
WORKDIR /dev-company
COPY --from=BUILDER /dev-company/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["echo", "test"]
ENTRYPOINT ["java", "-jar", "app.jar"]



#FROM eclipse-temurin:21-alpine
#WORKDIR /dev-company
#COPY gradle ./gradle
#COPY src ./src
#COPY gradlew build.gradle settings.gradle ./
#RUN --mount=type=cache,target=/root/.gradle ./gradlew --no-daemon -i clean bootJar
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "build/libs/dev-company-0.0.1-SNAPSHOT.jar"]