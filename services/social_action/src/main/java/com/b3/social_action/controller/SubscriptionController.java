package com.b3.social_action.controller;

import com.b3.social_action.dto.subscription.CreateSubscriptionDTO;
import com.b3.social_action.dto.subscription.DeleteSubscriptionDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.entity.Subscription;
import com.b3.social_action.service.SubscriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("subscription")
public class SubscriptionController {

    @Autowired
    public SubscriptionService subscriptionService;

    @GetMapping()
    public Page<Subscription> getAllSocialAction(@RequestParam("page") int page, @RequestParam("size") int size){
        return subscriptionService.list(page,size);
    }

    @PostMapping
    public ResponseEntity<CreateSubscriptionDTO> create(@RequestBody  CreateSubscriptionDTO dto, @RequestHeader UUID userID) throws Exception {
        var response = this.subscriptionService.create(dto, userID);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("{id}")
    public ResponseEntity<DeleteSubscriptionDTO> delete(@PathVariable UUID id) throws Exception {
        var responseOptional = this.subscriptionService.delete(id);
        if(responseOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        var response = responseOptional.get();
        return ResponseEntity.ok(response);
    }

}
