package com.b3.social_action.service;

import com.b3.social_action.dto.CreateSocialActionDTO;
import com.b3.social_action.dto.DeleteSocialActionDTO;
import com.b3.social_action.dto.UpdateSocialActionDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.repository.SocialActionRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

    public CreateSocialActionDTO createSocialAction(CreateSocialActionDTO socialActionDTO){
        var socialActionEntity = socialActionDTO.toEntity();
        var socialActionSave = socialActionRepository.save(socialActionEntity);
        return  new CreateSocialActionDTO(
                Optional.of(socialActionSave.getId()),
                socialActionSave.getName(),
                socialActionSave.getDate(),
                socialActionSave.getLocale(),
                socialActionSave.getResources()
        );
    }
    public Optional<UpdateSocialActionDTO> updateSocialAction(UpdateSocialActionDTO socialActionDTO, UUID id){
        var socialActionDatabaseOptional = socialActionRepository.findById(id);
        if(socialActionDatabaseOptional.isEmpty()){
            return Optional.empty();
        }
        var socialActionDatabase = socialActionDatabaseOptional.get();
        socialActionDatabase.setName(socialActionDTO.name());
        socialActionDatabase.setDate(socialActionDTO.date());
        socialActionDatabase.setLocale(socialActionDTO.locale());
        socialActionDatabase.setResources(socialActionDTO.resource());
        socialActionRepository.save(socialActionDatabase);

        return Optional.of(new UpdateSocialActionDTO(
                socialActionDatabase.getId(),
                socialActionDatabase.getName(),
                socialActionDatabase.getDate(),
                socialActionDatabase.getLocale(),
                socialActionDatabase.getResources()
        ));
    }

    public Optional<DeleteSocialActionDTO> deleteSocialAction(UUID id){
        var socialActionDatabaseOptional = socialActionRepository.findById(id);
        if(socialActionDatabaseOptional.isEmpty()){
            return Optional.empty();
        }
        var socialActionDatabase =  socialActionDatabaseOptional.get();
        socialActionRepository.deleteById(id);
        return Optional.of(new DeleteSocialActionDTO(
                socialActionDatabase.getId(),
                socialActionDatabase.getName(),
                socialActionDatabase.getDate(),
                socialActionDatabase.getLocale(),
                socialActionDatabase.getResources()
        ));
    }

    private LocalDateTime transformDate(String dateString){
        var pattern = "yyyy-MM-dd HH:mm";
        var formatter = DateTimeFormatter.ofPattern(pattern);
        return LocalDateTime.parse(dateString, formatter);
    }

}
