package com.b3.api_gateway.repository;

import com.b3.api_gateway.helper.RequestContract;
import com.b3.api_gateway.helper.HeaderFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

@Repository
public class TaskRepository {

    @Value("${baseURLSocialAction}")
    private String baseURL;

    private String  path = "task";
    @Autowired
    private RequestContract request;


    Logger logger = LoggerFactory.getLogger(this.getClass());


    public Map search(String search) throws Exception {

        var url =  String.format("%s/%s/{search}", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makeGetRequest(url, null, null,Map.class,search);
        return response;

    }
    public Map createTask(Map dto) throws Exception {
        var url = String.format("%s/%s", this.baseURL, this.path);

        var response = (LinkedHashMap)  this.request.makePostRequest(url, dto, HeaderFactory.make(),Map.class);
        return response;
    }
    public Map updateTask(Map dto, UUID id) throws Exception {

        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makePutRequest(url, dto, HeaderFactory.make(),Map.class, id);
        return response;
    }
    public Map deleteTask(UUID id) throws Exception {
        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makeDeleteRequest(url, null, HeaderFactory.make(),Map.class,id);
        return response;
    }

    public Map getTaskByID(UUID id) throws Exception {
        var url =  String.format("%s/%s/{id}", this.baseURL, this.path);
        var response = (LinkedHashMap)  this.request.makeGetRequest(url, null, null,Map.class,id);
        return response;
    }
}
