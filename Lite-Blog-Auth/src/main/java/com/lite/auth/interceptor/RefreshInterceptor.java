package com.lite.auth.interceptor;


import com.lite.common.exception.BaseException;
import com.lite.common.i18n.LocalMessages;
import com.lite.common.utils.JwtUtil;
import com.lite.auth.exception.AuthException;
import com.lite.auth.utils.Authenticator;
import io.jsonwebtoken.lang.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * RefreshToken拦截器，只拦截用于刷新token的接口
 */
@Order(3)
@Component
public class RefreshInterceptor implements HandlerInterceptor {

    @Autowired
    Authenticator authenticator;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        try {
            //获取refresh token
            String refreshToken = request.getHeader(JwtUtil.JWT_REFRESH_KEY);

            //获取accessToken
            String accessToken = request.getHeader(JwtUtil.JWT_ACCESS_KEY);

            //断言
            Assert.notNull(refreshToken, LocalMessages.get("error.jwt.access.notNull"));
            Assert.notNull(accessToken, LocalMessages.get("error.jwt.refresh.notNull"));

            //校验
            if (!authenticator.authenticateRefreshToken(refreshToken, accessToken))
                throw new AuthException(HttpStatus.FORBIDDEN.value(), LocalMessages.get("error.jwt.refresh.invalid"));

            //因为获取的是refresh-token，此时再做时效判断没有意义，解析失败一律403，需要重新登陆获取refresh-token
        } catch (BaseException e) {
            response.sendError(e.getStatus(), e.getMessage());
            return false;
        } catch (Exception e) {
            response.sendError(HttpStatus.FORBIDDEN.value(), e.getMessage());
            return false;
        }

        return true;
    }

}
