package com.b3.social_action.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;

@RestController
@RequestMapping("health-check")
public class HealthCheckController {

    @GetMapping
    public Map healthCheck(){
        return Collections.singletonMap("message", "se você ta vendo isso é um problema a menos(Social Action)");
    }

}
