package com.web.authenticate;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.web.authentication.WebAuthenticationDetails;

public class UserAuthenticationDetails extends WebAuthenticationDetails {
	private static final long serialVersionUID = 2012033417540858020L;

	private String loginType;

	public String getLoginType() {
		return loginType;
	}
	
	public UserAuthenticationDetails(HttpServletRequest request) {
		super(request);
		this.loginType = request.getParameter("loginType");
	}
}
