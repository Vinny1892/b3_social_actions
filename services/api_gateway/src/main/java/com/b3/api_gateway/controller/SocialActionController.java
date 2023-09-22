package com.b3.api_gateway.controller;

import com.b3.api_gateway.dto.CreateSocialActionDTO;
import com.b3.api_gateway.dto.UpdateSocialActionDTO;
import com.b3.api_gateway.repository.SocialActionRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;


@RestController
@RequestMapping("/social_actions")
public class SocialActionController {

    Logger logger =  LoggerFactory.getLogger(SocialActionController.class);

    @Autowired
    SocialActionRepository socialActionRepository;

    @GetMapping
    public List getSocialActions(
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "1") int page)
    {
        logger.info("get paginate social actions");
        return socialActionRepository.listPaginateSocialActions(size,page);
    }

    @GetMapping("{id}")
    public Map getSocialActions(@PathVariable(required = true) UUID id){
        return socialActionRepository.getSocialActionByID(id);
    }

    @PostMapping
    public ResponseEntity createSocialAction(@RequestBody CreateSocialActionDTO requestBody){
        socialActionRepository.createSocialAction(requestBody);
        return ResponseEntity.noContent().build();
    }

    @PutMapping
    public ResponseEntity updateSocialAction(
            @PathVariable(required = true) UUID id,
            @RequestBody UpdateSocialActionDTO requestBody){
        socialActionRepository.updateSocialAction(requestBody, id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("{id}")
    public ResponseEntity deleteSocialAction(@PathVariable UUID id){
        socialActionRepository.deleteSocialAction(id);
        return ResponseEntity.noContent().build();
    }



}
