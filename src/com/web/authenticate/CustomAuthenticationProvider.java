package com.web.authenticate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.web.utils.DbUtils;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	private boolean firstLogin = false;

	@Override
	public Authentication authenticate(Authentication authentication) {
		String name = authentication.getName();
		String password = authentication.getCredentials().toString();
		UserAuthenticationDetails webAuthenticationDetails = ((UserAuthenticationDetails) authentication.getDetails());
		if (checkUser(name, password, webAuthenticationDetails.getLoginType())) {
			List<GrantedAuthority> grantedAuths = new ArrayList<>();
			if(webAuthenticationDetails.getLoginType().equals("user")){
				grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));
				if(firstLogin){
					grantedAuths.add(new SimpleGrantedAuthority("USER_FIRST_LOGIN"));
				}else{
					grantedAuths.add(new SimpleGrantedAuthority("USER_NOT_FIRST_LOGIN"));
				}
			}else if(webAuthenticationDetails.getLoginType().equals("admin")){
				grantedAuths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
			}
			Authentication auth = new UsernamePasswordAuthenticationToken(name, password, grantedAuths);
			return auth;
		} else {
			return null;
		}
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

	private boolean checkUser(String username, String password, String loginType) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement st = null;
		try {
			conn = dataSource.getConnection();
			if(loginType.equals("admin")){
				st = conn.prepareStatement("select * from adminstaff where username = ? and password = ?");
			}else if(loginType.equals("user")){
				st = conn.prepareStatement("select * from physician where username = ? and password = ?");
			}
			st.setString(1, username);
			st.setString(2, password);
			rs = st.executeQuery();
			if (rs.next()) {
				if(loginType.equals("user")){
					firstLogin = DbUtils.getBoolean(rs, "FirstLogin");
				}
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtils.close(conn);
			DbUtils.close(rs);
			DbUtils.close(st);
		}
		return false;
	}

}
