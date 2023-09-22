package com.b3.api_gateway.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {

        return httpSecurity.csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> { session.sessionCreationPolicy(SessionCreationPolicy.STATELESS);})
                .authorizeHttpRequests(authReq -> {
                    authReq.requestMatchers("/.~~spring-boot!~/**").anonymous();
                    authReq.anyRequest().permitAll();
                })
                .build();
    }

}
