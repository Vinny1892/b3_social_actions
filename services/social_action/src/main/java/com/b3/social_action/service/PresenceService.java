package com.b3.social_action.service;

import com.b3.social_action.dto.presence.CreatePresenceDTO;
import com.b3.social_action.dto.presence.DeletePresenceDTO;
import com.b3.social_action.dto.subscription.CreateSubscriptionDTO;
import com.b3.social_action.dto.subscription.DeleteSubscriptionDTO;
import com.b3.social_action.entity.Presence;
import com.b3.social_action.entity.Subscription;
import com.b3.social_action.exceptions.BadRequestException;
import com.b3.social_action.exceptions.NotFoundException;
import com.b3.social_action.exceptions.UnprocessableEntityException;
import com.b3.social_action.repository.PresenceRepository;
import com.b3.social_action.repository.SubscriptionRepository;
import com.b3.social_action.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;
@Service
public class PresenceService {

    @Autowired
    PresenceRepository presenceRepository;

    @Autowired
    SubscriptionRepository subscriptionRepository;

    @Autowired
    TaskRepository taskRepository;

    public CreatePresenceDTO create(CreatePresenceDTO createPresenceDTO, UUID userID)  throws  Exception {
        var taskOptional = this.taskRepository.findById(createPresenceDTO.taskID());

        if(taskOptional.isEmpty()){
            throw  new UnprocessableEntityException("task doesnt exists");
        }
        var task = taskOptional.get();

        var subscriptionOptional = this.subscriptionRepository.findByUserIDAndTask(userID,task);
        if(subscriptionOptional.isEmpty()){
            throw  new BadRequestException("user doesnt register in task");
        }
        var subscription = subscriptionOptional.get();
        var userAlreadyRegisterPresence = presenceRepository.findByUserIDAndTask(userID,task);

        if(userAlreadyRegisterPresence.isPresent()){
            throw  new BadRequestException("usuario ja fez registro de presença");

        }

        var presence = new Presence(createPresenceDTO.id().orElse(UUID.randomUUID()),subscription, userID,task);
        this.presenceRepository.save(presence);
        return  new CreatePresenceDTO(
                Optional.of(presence.getId()),
                Optional.of(presence.getUserID()),
                subscription.getTask().getId()
        );
    }

    public Page<Presence> list(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return this.presenceRepository.findAll(pageable);
    }
    public Optional<DeletePresenceDTO> delete(UUID id){
        var optionalPresence = this.presenceRepository.findById(id);
        if(optionalPresence.isEmpty()){
            return Optional.empty();
        }
        var presence = optionalPresence.get();
        this.presenceRepository.delete(presence);
        return Optional.of(new DeletePresenceDTO(
                presence.getId(),
                presence.getTask().getId()
        ));
    }

}
