package com.b3.api_gateway.helper;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;

public interface RequestContract {

    private Object makeRequest(String url, HttpMethod method, Object body, HttpHeaders headers, Class responseType, Object... uriVariables) {
        return null;
    }

    public Object makeGetRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception;
    public Object makePostRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception;
    public Object makePutRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception;
    public Object makeDeleteRequest(String url, Object body, HttpHeaders headers , Class responseType, Object... uriVariables) throws Exception;


}
