package com.b3.social_action.service;

import com.b3.social_action.dto.subscription.CreateSubscriptionDTO;
import com.b3.social_action.dto.subscription.DeleteSubscriptionDTO;
import com.b3.social_action.dto.task.CreateTaskDTO;
import com.b3.social_action.entity.Presence;
import com.b3.social_action.entity.Subscription;
import com.b3.social_action.exceptions.BadRequestException;
import com.b3.social_action.exceptions.UnprocessableEntityException;
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
public class SubscriptionService {

    @Autowired
    SubscriptionRepository subscriptionRepository;
    @Autowired
    TaskRepository taskRepository;


    public CreateSubscriptionDTO create(CreateSubscriptionDTO createSubscriptionDTO, UUID userID)  throws  Exception {
        var taskOptional = this.taskRepository.findById(createSubscriptionDTO.taskID());
        if(taskOptional.isEmpty()){
            throw  new UnprocessableEntityException("task doesnt exists");
        }
        var task = taskOptional.get();
        var isUserSubscription = subscriptionRepository.findByUserIDAndTask(userID, task);
        if(isUserSubscription.isPresent()){
            throw  new BadRequestException("usuario ja está inscrito");
        }

        var numberOfSubscriptions = subscriptionRepository.countByTask(task);
        if(numberOfSubscriptions >= task.getQuantityOfVacancy()){
            throw new BadRequestException("none vacancies for task");
        }
        var subscription = new Subscription(createSubscriptionDTO.id().orElse(UUID.randomUUID()),task, userID);
        this.subscriptionRepository.save(subscription);
        return   new CreateSubscriptionDTO(
                Optional.of(subscription.getId()),
                subscription.getTask().getId(),
                Optional.of(subscription.getUserID())
        );
    }

    public Page<Subscription> list(int page, int size)  {
        Pageable pageable = PageRequest.of(page, size);
        return this.subscriptionRepository.findAll(pageable);
    }

    public Optional<DeleteSubscriptionDTO> delete(UUID id){
        var optionalSubscription = this.subscriptionRepository.findById(id);
        if(optionalSubscription.isEmpty()){
            return Optional.empty();
        }
        var subscription = optionalSubscription.get();
        this.subscriptionRepository.delete(subscription);
        return Optional.of(new DeleteSubscriptionDTO(
                subscription.getId(),
                subscription.getTask().getId()
        ));
    }

}
