package com.b3.api_gateway.repository;

import com.b3.api_gateway.helper.RequestContract;
import com.b3.api_gateway.helper.HeaderFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.util.*;


@Repository
public class SocialActionRepository {

    @Value("${baseURLSocialAction}")
    private String baseURL;

    private String  path = "social-action";

    @Autowired
    private RequestContract request;
    Logger logger = LoggerFactory.getLogger(this.getClass());


    public List search(String search) throws Exception {

        var url =  String.format("%s/%s/search/{search}", this.baseURL, this.path);

        var response = (List)  this.request.makeGetRequest(url, null, null,List.class,search);
        return response;

    }
    public Map listPublicPaginateSocialActions(int size, int page) throws Exception {
        var url = String.format("%s/%s/public?page={page}&size={size}", this.baseURL, this.path);
        var response =  (LinkedHashMap) this.request.makeGetRequest(url,null, null, Map.class,page,size);
        logger.info("calling social action microservice");
        return response;
    }
    public Map listPrivatePaginateSocialActions(int size, int page) throws Exception {
        var url = String.format("%s/%s/private?page={page}&size={size}", this.baseURL, this.path);
        var response =  (LinkedHashMap) this.request.makeGetRequest(url,null, null, Map.class,page,size);
        logger.info("calling social action microservice");
        return response;
    }

    public Map getSocialActionByID(UUID id) throws Exception {
        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makeGetRequest(url, null, null,Map.class,id);
        return response;
    }

    public Map createSocialAction(Map dto) throws Exception {
        var url = String.format("%s/%s", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makePostRequest(url, dto,HeaderFactory.make(),Map.class);
        return response;
    }
    public Map updateSocialAction(Map dto, UUID id) throws Exception {

        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makePutRequest(url, dto,HeaderFactory.make(),Map.class,id);
        return response;
    }
    public Map deleteSocialAction(UUID id) throws Exception {
        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makeDeleteRequest(url, null, HeaderFactory.make(),Map.class,id);
        return response;
    }

}
