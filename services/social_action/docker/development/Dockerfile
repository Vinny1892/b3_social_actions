FROM maven:3.9.4-eclipse-temurin-17 as build

WORKDIR /app
COPY .  .

RUN mvn dependency:resolve
RUN mvn dependency:resolve-plugins



FROM eclipse-temurin:17-jdk-jammy

COPY --from=build  /root/.m2 /root/.m2

RUN apt update && apt install wget  sudo  gnupg2 -y
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

RUN  apt install  postgresql-client-14 -y


WORKDIR /app

COPY . .

CMD ["docker/development/wait-for-it.sh"]
