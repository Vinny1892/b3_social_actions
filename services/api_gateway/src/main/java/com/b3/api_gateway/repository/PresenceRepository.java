package com.b3.api_gateway.repository;

import com.b3.api_gateway.helper.Request;
import com.b3.api_gateway.helper.RequestContract;
import com.b3.api_gateway.helpers.HeaderFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

@Repository
public class PresenceRepository {
    @Value("${baseURLSocialAction}")
    private String baseURL;

    @Autowired
    private RequestContract request;

    private String  path = "presence";

    Logger logger = LoggerFactory.getLogger(this.getClass());


    public Map createPresence(Map dto) throws Exception {
        var url = String.format("%s/%s", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makePostRequest(url, dto, HeaderFactory.make(),Map.class);
        return response;
    }

    public Map getAllPresence(int page,  int size) throws Exception {
        var url = String.format("%s/%s?page={page}&size={size}", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makeGetRequest(url, null, HeaderFactory.make(),Map.class,page,size);
        return response;
    }

    public Map deletePresence(UUID id) throws Exception {
        var url = String.format("%s/%s/{id}", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makeDeleteRequest(url, null, HeaderFactory.make(), Map.class, id);
        return response;
    }




}
