package com.b3.api_gateway.repository;

import com.b3.api_gateway.dto.CreateSocialActionDTO;
import com.b3.api_gateway.dto.UpdateSocialActionDTO;
import com.b3.api_gateway.helper.Request;
import com.b3.api_gateway.helper.RequestContract;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

import java.security.Security;
import java.util.*;


@Repository
public class SocialActionRepository {

    @Value("${baseURLSocialAction}")
    private String baseURL;

    private String  path = "social-action";
    private HttpHeaders httpHeaders;



    private RequestContract request;
    Logger logger = LoggerFactory.getLogger(this.getClass());

    public SocialActionRepository() {
        this.httpHeaders = makeHeader();
        this.request = new Request();
    }
    private HttpHeaders makeHeader(){
        var user = (JwtAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + user.getToken().getTokenValue());
        headers.set("userID", (String) user.getToken().getClaims().get("sub"));
        headers.set("email", (String) user.getToken().getClaims().get("email"));
        return headers;
    }

    public Map listPaginateSocialActions(int size, int page) throws Exception {
        var url = String.format("%s/%s?page={page}&size={size}", this.baseURL, this.path);
        var response =  (LinkedHashMap) this.request.makeGetRequest(url,null,this.httpHeaders, Map.class,page,size);
        logger.info("calling social action microservice");
        return response;
    }

    public Map getSocialActionByID(UUID id) throws Exception {
//        var uuid = UUID.randomUUID().toString();
//        String url = "https://jsonplaceholder.typicode.com/posts/{id}";
//        this.restTemplate.getForObject(url, LinkedHashMap.class);
        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makeGetRequest(url, null, this.httpHeaders,Map.class,id);
        return response;
    }

    public Map createSocialAction(Map dto) throws Exception {
        var url = String.format("%s/%s", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makePostRequest(url, dto, this.httpHeaders,Map.class);
        return response;
    }
    public Map updateSocialAction(UpdateSocialActionDTO dto, UUID id) throws Exception {

        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makePutRequest(url, dto, this.httpHeaders,Map.class);
        return response;
    }
    public Map deleteSocialAction(UUID id) throws Exception {
        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makeDeleteRequest(url, null, this.httpHeaders,Map.class);
        return response;
    }

}
