package com.b3.api_gateway.config.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.MDC;
;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Optional;
import java.util.UUID;

public class CorrelationIDInterceptor implements HandlerInterceptor {
    private static String CORRELATION_ID_NAME = "correlationId";


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        var correlationId = searchCorrelationId(request);
        MDC.put(CORRELATION_ID_NAME, correlationId);
        return true;
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        MDC.remove(CORRELATION_ID_NAME);
    }

    private String searchCorrelationId(HttpServletRequest request){
        Optional<String> correlationId = Optional.ofNullable(request.getHeader("correlation-id"));
        if(correlationId.isEmpty()){
            return UUID.randomUUID().toString();
        }
        return correlationId.get();
    }

}
