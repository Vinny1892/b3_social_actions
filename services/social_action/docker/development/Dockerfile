FROM maven:3.9.4 as build

WORKDIR /app

COPY . .

RUN mvn -f /app/pom.xml clean package -D maven.test.skip


FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

COPY --from=build /app ./

CMD ["docker/development/wait-for-it.sh"]