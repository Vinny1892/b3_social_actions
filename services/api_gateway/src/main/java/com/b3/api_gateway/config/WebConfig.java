package com.b3.api_gateway.config;

import com.b3.api_gateway.config.interceptor.CorrelationIDInterceptor;
import com.b3.api_gateway.config.interceptor.LogRequestInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(new CorrelationIDInterceptor());
        registry.addInterceptor(new LogRequestInterceptor());
    }
}
