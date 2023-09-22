package com.b3.api_gateway.repository;

import com.b3.api_gateway.dto.CreateSocialActionDTO;
import com.b3.api_gateway.dto.UpdateSocialActionDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import java.util.*;


@Repository
public class SocialActionRepository {

    @Value("${baseURLSocialAction}")
    private String baseURL;
    Logger logger = LoggerFactory.getLogger(SocialActionRepository.class);

    @Autowired
    private RestTemplate restTemplate;

    public List listPaginateSocialActions(int size, int page){
        logger.info("calling social action microservice ");
        String url = "https://jsonplaceholder.typicode.com/posts?_page={page}&_limit={size}";
        var response = restTemplate.getForObject(url, List.class, page, size);
        return response;
    }

    public Map getSocialActionByID(UUID id){
        String url = "https://jsonplaceholder.typicode.com/posts/{id}";
        this.restTemplate.getForObject(url, LinkedHashMap.class, 1);
        return Collections.emptyMap();
    }

    public void createSocialAction(CreateSocialActionDTO dto){

    }
    public void updateSocialAction(UpdateSocialActionDTO dto, UUID id){

    }
    public void deleteSocialAction(UUID id){

    }

}
