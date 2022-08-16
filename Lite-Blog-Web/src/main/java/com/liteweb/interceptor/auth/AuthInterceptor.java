package com.liteweb.interceptor.auth;

import com.liteweb.exception.auth.AuthException;
import com.liteweb.utils.auth.Authenticator;
import com.liteweb.utils.auth.JwtUtil;
import io.jsonwebtoken.ExpiredJwtException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Autowired
    Authenticator authenticator;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {

        try {

            //获取请求头中的token
            String accessToken = request.getHeader(JwtUtil.JWT_ACCESS_KEY);

            //断言
            Assert.notNull(accessToken,"AccessToken为空");

            if (!authenticator.authenticateAccessToken(accessToken))
                throw new AuthException();

        } catch (ExpiredJwtException e) {
            //token过期
            response.sendError(HttpStatus.UNAUTHORIZED.value(),HttpStatus.UNAUTHORIZED.toString());
            return false;
        } catch (Exception e){
            response.sendError(HttpStatus.FORBIDDEN.value(),HttpStatus.FORBIDDEN.toString());
            return false;
        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
