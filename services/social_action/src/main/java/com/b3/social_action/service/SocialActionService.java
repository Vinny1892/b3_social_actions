package com.b3.social_action.service;

import com.b3.social_action.dto.social_action.CreateSocialActionDTO;
import com.b3.social_action.dto.social_action.DeleteSocialActionDTO;
import com.b3.social_action.dto.social_action.UpdateSocialActionDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.exceptions.UnprocessableEntityException;
import com.b3.social_action.repository.OngRepository;
import com.b3.social_action.repository.SocialActionRepository;
import com.b3.social_action.repository.TaskRepository;
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

    @Autowired
    public TaskRepository taskRepository;

    @Autowired
    public OngRepository ongRepository;
    
    
    public Page<SocialAction> listSocialActions(int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        var response = socialActionRepository.findAll(pageable);
        return response;
    }

    public Optional<SocialAction> getSocialActionBy(UUID id){
        return socialActionRepository.findById(id);
    }

    public CreateSocialActionDTO createSocialAction(CreateSocialActionDTO socialActionDTO){
        var socialActionEntity = socialActionDTO.toEntity();
        var ongID = socialActionDTO.ongID();
        if(ongID.isPresent()){
            var isOngExist = ongRepository.findById(ongID.get());
            if(isOngExist.isPresent()){
                socialActionEntity.setOng(isOngExist.get());
            }
        }

        var socialActionSave = socialActionRepository.save(socialActionEntity);
        return  new CreateSocialActionDTO(
                Optional.of(socialActionSave.getId()),
                ongID,
                socialActionSave.getName()
        );
    }
    public Optional<UpdateSocialActionDTO> updateSocialAction(UpdateSocialActionDTO socialActionDTO, UUID id){
        var socialActionDatabaseOptional = socialActionRepository.findById(id);
        if(socialActionDatabaseOptional.isEmpty()){
            return Optional.empty();
        }
        var socialActionDatabase = socialActionDatabaseOptional.get();
        socialActionDatabase.setName(socialActionDTO.name());
        socialActionRepository.save(socialActionDatabase);

        return Optional.of(new UpdateSocialActionDTO(
                socialActionDatabase.getId(),
                socialActionDatabase.getName()
        ));
    }

    public Optional<DeleteSocialActionDTO> deleteSocialAction(UUID id){
        var socialActionDatabaseOptional = socialActionRepository.findById(id);
        if(socialActionDatabaseOptional.isEmpty()){
            return Optional.empty();
        }
        var socialActionDatabase =  socialActionDatabaseOptional.get();
        socialActionDatabase.getTasks().stream().forEach(task -> {
            taskRepository.delete(task);
        });
        socialActionRepository.deleteById(id);
        return Optional.of(new DeleteSocialActionDTO(
                socialActionDatabase.getId(),
                socialActionDatabase.getName()
        ));
    }

    private LocalDateTime transformDate(String dateString){
        var pattern = "yyyy-MM-dd HH:mm";
        var formatter = DateTimeFormatter.ofPattern(pattern);
        return LocalDateTime.parse(dateString, formatter);
    }

    public Page<SocialAction> listSocialActionsByCategory(Long categoriaId, int page, int size) {
        return null;
    }

    

}

