package com.b3.api_gateway.controller;

import com.b3.api_gateway.repository.OngRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/ong")
public class OngController {

    @Autowired
    OngRepository ongRepository;

    @GetMapping("{search}")
    public List search(@PathVariable(value = "search") String search) throws Exception {
        var response = ongRepository.search(search);
        return response;
    }
}
