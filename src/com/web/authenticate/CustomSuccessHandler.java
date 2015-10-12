package com.web.authenticate;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {

	@Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {
        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
        if (roles.contains("ROLE_ADMIN")){
            response.sendRedirect(request.getContextPath() + "/admin/home");   
            return;
        }
        if(roles.contains("ROLE_USER") && roles.contains("USER_FIRST_LOGIN")){
        	response.sendRedirect(request.getContextPath() + "/frontend/firstlogin");   
            return;
        }
        if(roles.contains("ROLE_USER") && roles.contains("USER_NOT_FIRST_LOGIN")){
        	response.sendRedirect(request.getContextPath() + "/frontend/notfirstlogin");   
            return;
        }
        response.sendRedirect(request.getContextPath() + "/frontend/home");
    }    

}
