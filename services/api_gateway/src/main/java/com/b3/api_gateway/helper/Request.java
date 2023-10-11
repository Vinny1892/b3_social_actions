package com.b3.api_gateway.helper;

import com.b3.api_gateway.controller.SocialActionController;
import com.b3.api_gateway.exceptions.BadRequestException;
import com.b3.api_gateway.exceptions.NotFoundException;
import com.b3.api_gateway.exceptions.ServerException;
import com.b3.api_gateway.exceptions.UnprocessableException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.Map;
import java.util.Optional;


@Component
public class Request implements  RequestContract {

    private RestTemplate restTemplate;

    Logger logger =  LoggerFactory.getLogger(this.getClass());


    public Request() {
        this.restTemplate = new RestTemplate();
    }

    public Object makePostRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception {
        return this.makeRequest(url,HttpMethod.POST,body,headers,responseType,uriVariables);

    }
    public Object makePutRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception {
        return this.makeRequest(url,HttpMethod.PUT,body,headers,responseType,uriVariables);

    }

    public Object makeDeleteRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception {
        return this.makeRequest(url,HttpMethod.DELETE,body,headers,responseType,uriVariables);

    }
    public Object  makeGetRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception {
        return this.makeRequest(url,HttpMethod.GET,body,headers,responseType,uriVariables);
    }

    private Object makeRequest(String url, HttpMethod method, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws  Exception {
        try {
            var httpEntity = new HttpEntity(body, headers);
            return this.restTemplate.exchange(url, method, httpEntity, responseType, uriVariables).getBody();
        } catch (HttpClientErrorException e) {
            logger.debug("erro 4xx in api gateway");
            // Trata erros 4xx (por exemplo, 400, 404, 422)
            var statusCode = e.getStatusCode();
            if (HttpStatus.UNPROCESSABLE_ENTITY.equals(statusCode)) {
                logger.error("erro  ao processar request, 422", e.getMessage());
                throw new UnprocessableException("erro ao processar requisição");
            } else if (HttpStatus.BAD_REQUEST.equals(statusCode)) {
                throw new BadRequestException("erro ao processar requisição");
            } else if (HttpStatus.NOT_FOUND.equals(statusCode)) {
                throw new NotFoundException("recurso nao encontrado");
            } else {
                throw new ServerException("Erro no servidor");
            }
        } catch (HttpServerErrorException e) {
            logger.error(e.getMessage());
            logger.error("resposta do servidor não está em nenhum filtro de tratamento do gateway", e.getMessage());
            throw new ServerException("Erro no servidor");
        } catch (Exception e) {
            logger.error("erro na aplicação antes de fazer a request", e.getMessage());
            e.printStackTrace();
            throw new ServerException("Erro no servidor");
        }
    }



}
