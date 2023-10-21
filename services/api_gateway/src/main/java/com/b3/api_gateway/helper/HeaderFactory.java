package com.b3.api_gateway.helper;

import org.springframework.http.HttpHeaders;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

public class HeaderFactory {

    static public HttpHeaders make(){
        var user = (JwtAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + user.getToken().getTokenValue());
        headers.set("userID", (String) user.getToken().getClaims().get("sub"));
        headers.set("email", (String) user.getToken().getClaims().get("email"));
        return headers;
    }
}
