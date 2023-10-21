package com.b3.social_action.controller;

import com.b3.social_action.entity.Ong;
import com.b3.social_action.repository.OngRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("ong")
public class OngController {

    @Autowired
    public OngRepository ongRepository;

    @PostMapping
    public void createRepository(){
        var ong =  new Ong();
        ong.setId(UUID.randomUUID());
        ong.setName("teste");
        ongRepository.save(ong);
    }

    @GetMapping("{search}")
    public ResponseEntity search(
            @PathVariable(value = "search") String search){
        var ong = ongRepository.findOngByNameContainsIgnoreCase(search);
        return ResponseEntity.ok().body(ong);
    }
}
