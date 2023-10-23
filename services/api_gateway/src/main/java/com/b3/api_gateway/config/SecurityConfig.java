package com.b3.api_gateway.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {

         httpSecurity.csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> { session.sessionCreationPolicy(SessionCreationPolicy.STATELESS);})
                .authorizeHttpRequests(authReq -> {
                    authReq.requestMatchers(HttpMethod.OPTIONS).permitAll();
                    authReq.requestMatchers("/.~~spring-boot!~/**").anonymous();
                    authReq.requestMatchers("/health-check/**").permitAll();
                    authReq.requestMatchers(HttpMethod.GET,"/social_actions/public").permitAll();
                    authReq.requestMatchers(HttpMethod.GET,"/social_actions/**").permitAll();

                    authReq.anyRequest().fullyAuthenticated();
//                    authReq.anyRequest().permitAll();
                });

        httpSecurity.oauth2ResourceServer(oauth2ResourceServer -> oauth2ResourceServer.jwt(configure -> {
            configure.jwtAuthenticationConverter(new JWTConverter());
        }));
        return httpSecurity.build();
    }

}
