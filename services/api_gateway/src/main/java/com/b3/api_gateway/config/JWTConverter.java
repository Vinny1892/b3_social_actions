package com.b3.api_gateway.config;

import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

import java.util.Collection;
import java.util.Map;


public class JWTConverter  implements Converter<Jwt, AbstractAuthenticationToken> {
    @Override
    public AbstractAuthenticationToken convert(Jwt jwt) {
        Map<String, Collection<String>> realmAcess = jwt.getClaim("realm_access");
        Collection<String> roles = realmAcess.get("roles");
        var grants = roles
                .stream()
                .map(role -> new SimpleGrantedAuthority(role)).toList();
        //passar parametro name no construtor;
        return new JwtAuthenticationToken(jwt,grants);
    }
}
