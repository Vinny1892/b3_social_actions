package com.b3.social_action.controller;

import com.b3.social_action.entity.Ong;
import com.b3.social_action.repository.OngRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
