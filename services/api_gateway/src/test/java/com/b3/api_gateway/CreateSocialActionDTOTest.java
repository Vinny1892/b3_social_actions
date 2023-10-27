package com.b3.api_gateway;

import com.b3.api_gateway.dto.CreateSocialActionDTO;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CreateSocialActionDTOTest {

    @Test
    public void testCreateSocialActionDTO() {
        String name = "Social Event";
        String date = "2023-10-30T08:00:00";
        LocalDateTime locale = LocalDateTime.now();
        String resource = "Community Center";

        CreateSocialActionDTO dto = new CreateSocialActionDTO(name, date, locale, resource);

        // Verifique se os campos foram definidos corretamente
        assertEquals(name, dto.name());
        assertEquals(date, dto.date());
        assertEquals(locale, dto.locale());
        assertEquals(resource, dto.resource());
    }
}
