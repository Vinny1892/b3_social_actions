package com.b3.social_action.Consumer;

import com.b3.social_action.DTO.CreateSocialActionDTO;
import com.b3.social_action.Service.SocialActionService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;

@Component
public class CreateSocialActionConsumer {

    @Autowired
    SocialActionService socialActionService;

    @RabbitListener(queues = "${spring.rabbitmq.queue}")
    public void listen(@Payload CreateSocialActionDTO createSocialActionDTO){
            socialActionService.createSocialAction(createSocialActionDTO);
    }

}
