package com.b3.api_gateway;

import com.b3.api_gateway.dto.UpdateSocialActionDTO;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

public class UpdateSocialActionDTOTest {

    @Test
    public void testCreateUpdateSocialActionDTO() {
        UpdateSocialActionDTO dto1 = new UpdateSocialActionDTO("New Name", "2023-10-30T08:00:00", null, "New Resource");
        UpdateSocialActionDTO dto2 = new UpdateSocialActionDTO("Another Name", "2023-11-15T14:30:00", null, "Another Resource");

        // Verifique se as instâncias são criadas corretamente
        assertEquals("New Name", dto1.name());
        assertEquals("Another Name", dto2.name());
        assertEquals("New Resource", dto1.resource());
        assertEquals("Another Resource", dto2.resource());
    }

    @Test
    public void testEquality() {
        UpdateSocialActionDTO dto1 = new UpdateSocialActionDTO("Name", "2023-10-30T08:00:00", null, "Resource");
        UpdateSocialActionDTO dto2 = new UpdateSocialActionDTO("Name", "2023-10-30T08:00:00", null, "Resource");
        UpdateSocialActionDTO dto3 = new UpdateSocialActionDTO("Different Name", "2023-11-15T14:30:00", null, "Different Resource");

        // Verifique a igualdade das instâncias
        assertEquals(dto1, dto2); // Deve ser igual
        assertNotEquals(dto1, dto3); // Deve ser diferente
    }
}

