package com.b3.social_action.integration;


import com.b3.social_action.dto.task.CreateTaskDTO;
import com.b3.social_action.entity.SocialAction;
import com.b3.social_action.entity.Task;
import com.b3.social_action.service.TaskService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Optional;
import java.util.UUID;

import static org.junit.matchers.JUnitMatchers.containsString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class CreateTaskIntegration {

    @Autowired
    private MockMvc mockMvc;


    @Test
    public void createTaskWhenSocialActionDoesntExist() throws Exception {
        var socialActionID = UUID.randomUUID();
//        var socialAction = new SocialAction(
//                "teste",
//                "PUBLICO",
//                LocalDateTime.now().plusHours(2),
//                LocalDateTime.now().plusHours(8),
//                "descrição de teste",
//        "seila@seila.com"
//        );
//        socialAction.setId(UUID.randomUUID());
        // Crie um objeto CreateTaskDTO para simular a entrada
        CreateTaskDTO inputDto = new CreateTaskDTO(// O ID pode ser deixado como vazio (será preenchido pelo serviço)
                Optional.empty(),
                socialActionID, // Social Action ID (gerado aleatoriamente)
                "Sample Task Name",
                5                // Quantidade de vagas
        );

        CreateTaskDTO responseDTO = new CreateTaskDTO(// O ID pode ser deixado como vazio (será preenchido pelo serviço)
                Optional.of(UUID.randomUUID()),
                socialActionID, // Social Action ID (gerado aleatoriamente)
                "Sample Task Name",
                5                // Quantidade de vagas
        );
        var request = new LinkedHashMap<String, String>();
        request.put("social_action_id" , socialActionID.toString());
        request.put("name","Sample Task Name");
        request.put("quantityOfVacancy", "5");


        // Execute a solicitação POST
        mockMvc.perform(post("/task")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(new ObjectMapper().writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(header().string("Location", containsString("/task/")));

    }
}
