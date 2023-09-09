package com.b3.social_action.Controller;


import com.b3.social_action.Entity.SocialAction;
import com.b3.social_action.Repository.SocialActionRepository;
import com.b3.social_action.Service.SocialActionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

}
