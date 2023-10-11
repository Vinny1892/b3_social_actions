package com.b3.api_gateway.controller;


import com.b3.api_gateway.repository.SubscriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("subscription")
public class SubscriptionController {

    @Autowired
    SubscriptionRepository subscriptionRepository;

    @GetMapping()
    public Map getAllSocialAction(@RequestParam("page") int page, @RequestParam("size") int size) throws Exception {
        return subscriptionRepository.getAllSubscriptions(page,size);
    }

    @PostMapping
    public Map create(@RequestBody  Map dto) throws Exception {
        return subscriptionRepository.createSubscription(dto);
    }

    @DeleteMapping("{id}")
    public Map delete(@PathVariable UUID id) throws Exception {
        return subscriptionRepository.deleteSubscription(id);

    }
}
