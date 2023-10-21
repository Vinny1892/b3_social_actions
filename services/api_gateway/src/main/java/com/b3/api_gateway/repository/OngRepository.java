package com.b3.api_gateway.repository;

import com.b3.api_gateway.helper.RequestContract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OngRepository {
    @Value("${baseURLSocialAction}")
    private String baseURL;

    private String  path = "ong";
    @Autowired
    private RequestContract request;


    public List search(String search) throws Exception {

        var url =  String.format("%s/%s/{search}", this.baseURL, this.path);

        var response = (List)  this.request.makeGetRequest(url, null, null, List.class,search);
        return response;

    }
}
