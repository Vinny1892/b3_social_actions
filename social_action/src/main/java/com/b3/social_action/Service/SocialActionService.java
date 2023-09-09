package com.b3.social_action.Service;

import com.b3.social_action.DTO.CreateSocialActionDTO;
import com.b3.social_action.Entity.SocialAction;
import com.b3.social_action.Repository.SocialActionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
public class SocialActionService {

    @Autowired
    public SocialActionRepository socialActionRepository;
    
    
    public Page<SocialAction> listSocialActions(int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        return socialActionRepository.findAll(pageable);
    }

    public Optional<SocialAction> getSocialActionBy(UUID id){
        return socialActionRepository.findById(id);
    }

    public void createSocialAction(CreateSocialActionDTO socialActionDTO){
        var socialActionEntity = socialActionDTO.toEntity();
        socialActionRepository.save(socialActionEntity);
    }

}
