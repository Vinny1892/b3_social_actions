# Descrição do Projeto



# Setup

##  Pré-requisitos Linux/Windows
 
 Garantir que os seguintes progamas estejam instalados na maquina, em ambiente windows recomenda-se o uso do [wsl 2](https://learn.microsoft.com/en-us/windows/wsl/install)

 - Make
 - docker
 - docker-compose
 - intelij

 ## Estrutura do repositório

 - Os microserviços estão dentro da pasta `services`

 - a pasta `database` está a configuração da imagem docker do postgres
    
    - na pasta `keycloak`, está o dump do banco de dados do keycloak, onde está toda configuração de client,roles,usuarios e etc...

## Serviços Auxiliares

- [Keycloak](https://www.keycloak.org/)
    - portas: 8084
- [Rabbitmq](https://www.rabbitmq.com/)
    - portas: 5672, 15672
- [Postgres](https://www.postgresql.org/)
    - portas: 5432


#  Uso em ambiente de desenvolvimento

Após entrar na pasta de algum dos serviços   rodar o comando init:

 ```sh
    make init
 ```

Após o comando rodar pode-se verificar se os serviços auxiliares estão funcionais rodando o comando:

 ```sh
    docker ps 
 ```
Após entrar no intelij, verá que existe uma configuração chamada development, como na imagem abaixo.

<img src="./docs/assets/intelij-development-configuration.png">

Quando rodar essa configuração toda vez que o projeto for construido(build), será atualizado em tempo real a aplicação dentro do container

| Serviço | Porta | Tipo |
| ---| ---|---|
| api gateway | 8086 | microserviço |
| social action| 8086 | microserviço |
| contract | 8086 | microserviço |
| invoice | 8086 | microserviço |
| keycloak | 8084 | auxiliar |
| postgres | 5432 | auxiliar |
| rabbitmq | 15672 | auxiliar |
| rabbitmq | 5672 | auxiliar |








 



