package com.b3.api_gateway.controller;

import com.b3.api_gateway.dto.CreateSocialActionDTO;
import com.b3.api_gateway.dto.UpdateSocialActionDTO;
import com.b3.api_gateway.repository.SocialActionRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;


@RestController
@RequestMapping("/social_actions")
public class SocialActionController {

    Logger logger =  LoggerFactory.getLogger(this.getClass());

    @Autowired
    SocialActionRepository socialActionRepository;

    @GetMapping
    public Map getSocialActions(
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "1") int page) throws Exception {
        var response = socialActionRepository.listPaginateSocialActions(size,page);
        logger.info("get paginate social actions");

        return response;
    }

    @GetMapping("{id}")
    public Map getSocialActions(@PathVariable(required = true) UUID id) throws Exception {
        return socialActionRepository.getSocialActionByID(id);
    }

    @PreAuthorize("hasAuthority('CREATE_SOCIAL_ACTION')")
    @PostMapping
    public Map createSocialAction(@RequestBody Map requestBody) throws Exception {
       var response =  socialActionRepository.createSocialAction(requestBody);
       return response;
    }


    @PreAuthorize("hasAuthority('UPDATE_SOCIAL_ACTION')")
    @PutMapping
    public Map updateSocialAction(
            @PathVariable(required = true) UUID id,
            @RequestBody UpdateSocialActionDTO requestBody) throws Exception {
        var response = socialActionRepository.updateSocialAction(requestBody, id);
        return response;
    }

    @PreAuthorize("hasAuthority('DELETE_SOCIAL_ACTION')")
    @DeleteMapping("{id}")
    public Map deleteSocialAction(@PathVariable UUID id) throws Exception {
        var response = socialActionRepository.deleteSocialAction(id);
        return response;
    }



}
