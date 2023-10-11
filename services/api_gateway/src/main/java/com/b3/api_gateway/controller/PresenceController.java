package com.b3.api_gateway.controller;


import com.b3.api_gateway.repository.PresenceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("presence")
public class PresenceController {

    @Autowired
    PresenceRepository presenceRepository;

    @GetMapping()
    public Map getAllPresence(@RequestParam("page") int page, @RequestParam("size") int size) throws Exception {
        return presenceRepository.getAllPresence(page,size);
    }

    @PostMapping
    public Map create(@RequestBody Map dto) throws Exception {
      return presenceRepository.createPresence(dto);
    }

    @DeleteMapping
    public Map delete(@PathVariable UUID id) throws Exception {
        return presenceRepository.deletePresence(id);
    }

}
