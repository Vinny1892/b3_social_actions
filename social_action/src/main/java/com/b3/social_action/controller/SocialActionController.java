package com.b3.social_action.controller;


import com.b3.social_action.dto.CreateSocialActionDTO;
import com.b3.social_action.dto.DeleteSocialActionDTO;
import com.b3.social_action.dto.UpdateSocialActionDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.service.SocialActionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.UUID;

@RestController
@RequestMapping("/social-action")
public class SocialActionController {

    @Autowired
    public SocialActionService socialActionService;

    @GetMapping("{id}")
    public ResponseEntity getSocialAction(@PathVariable(value = "id") UUID socialActionID){
        var socialAction = socialActionService.getSocialActionBy(socialActionID);
        if(socialAction.isPresent()){
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(socialAction);
    }

    @GetMapping()
    public Page<SocialAction> getAllSocialAction(@RequestParam("page") int page, @RequestParam("size") int size){
        return socialActionService.listSocialActions(page,size);
    }

    @PostMapping()
    public ResponseEntity<CreateSocialActionDTO> createSocialAction(@RequestBody CreateSocialActionDTO dto,  UriComponentsBuilder uriBuilder){
       var socialAction = socialActionService.createSocialAction(dto);
       var uri = uriBuilder.path("/social-action/{id}").buildAndExpand(socialAction.id()).toUri();
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
