package com.b3.social_action.controller;

import com.b3.social_action.dto.presence.CreatePresenceDTO;
import com.b3.social_action.dto.presence.DeletePresenceDTO;
import com.b3.social_action.dto.subscription.CreateSubscriptionDTO;
import com.b3.social_action.dto.subscription.DeleteSubscriptionDTO;
import com.b3.social_action.entity.Presence;
import com.b3.social_action.entity.Subscription;
import com.b3.social_action.service.PresenceService;
import com.b3.social_action.service.SubscriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("presence")
public class PresenceController {


    @Autowired
    public PresenceService presenceService;


    @GetMapping()
    public Page<Presence> getAllPresence(@RequestParam("page") int page, @RequestParam("size") int size){
        return presenceService.list(page,size);
    }

    @PostMapping
    public ResponseEntity<CreatePresenceDTO> create(@RequestBody CreatePresenceDTO dto, @RequestHeader UUID userID) throws Exception {
        var response = this.presenceService.create(dto, userID);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("{id}")
    public ResponseEntity<DeletePresenceDTO> delete(@PathVariable UUID id) throws Exception {
        var responseOptional = this.presenceService.delete(id);
        if(responseOptional.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        var response = responseOptional.get();
        return ResponseEntity.ok(response);
    }
}
