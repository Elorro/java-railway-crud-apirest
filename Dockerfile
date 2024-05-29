FROM eclipse-temurin:22-jdk as buil

COPY . /app
WORKDIR /app

RUN chmod +x mvnw
RUN ./mvnw package -DskipTests
RUN mv -f target/*.jar app.jar

FROM eclipse-temurin:22-jdk

ARG PORT
ENV PORT=${PORT}

COPY --from=build /app/app.jar .

RUN useradd tuntime
USER runtime

ENTRYPOINT ["java", ".Dserver.port=${PORT}", ".jar", "app.jar"]