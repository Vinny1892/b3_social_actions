package com.b3.social_action.controller;


import com.b3.social_action.dto.social_action.CreateSocialActionDTO;
import com.b3.social_action.dto.social_action.DeleteSocialActionDTO;
import com.b3.social_action.dto.social_action.UpdateSocialActionDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.service.SocialActionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.UUID;

@RestController
@RequestMapping("/social-action")
public class SocialActionController {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    public SocialActionService socialActionService;

    @GetMapping("{id}")
    public ResponseEntity getSocialAction(
            @PathVariable(value = "id") UUID socialActionID){
        var socialAction = socialActionService.getSocialActionBy(socialActionID);
        if(socialAction.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(socialAction);
    }

    @GetMapping("/search/{search}")
    public ResponseEntity search(
            @PathVariable(value = "search") String search){
        var socialAction = socialActionService.search(search);
        if(socialAction.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(socialAction);
    }



    @GetMapping("/private")
    public Page<SocialAction> getAllPrivateSocialAction(@RequestParam("page") int page, @RequestParam("size") int size){
        return socialActionService.listPrivateSocialActions(page,size);
    }

    @GetMapping("/public")
    public Page<SocialAction> getAllPublicSocialAction(@RequestParam("page") int page, @RequestParam("size") int size){
        return socialActionService.listPublicSocialActions(page,size);
    }

    @PostMapping()
    public ResponseEntity<CreateSocialActionDTO> createSocialAction(@RequestBody CreateSocialActionDTO dto,  UriComponentsBuilder uriBuilder){
       var socialAction = socialActionService.createSocialAction(dto);
       var uri = uriBuilder.path("/social-action/{id}").buildAndExpand(socialAction.id().get()).toUri();
       return ResponseEntity.created(uri).body(socialAction);
    }

    @PutMapping("{id}")
    public ResponseEntity<UpdateSocialActionDTO> updateSocialAction(@RequestBody UpdateSocialActionDTO dto, @PathVariable UUID id){
        var socialActionUpdatedOptional = socialActionService.updateSocialAction(dto, id);
        if(socialActionUpdatedOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(socialActionUpdatedOptional.get());
    }

    @DeleteMapping("{id}")
    public ResponseEntity<DeleteSocialActionDTO> deleteSocialAction(@PathVariable UUID id){
        var socialActionDeletedOptional = socialActionService.deleteSocialAction(id);
        if(socialActionDeletedOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(socialActionDeletedOptional.get());
    }

}
