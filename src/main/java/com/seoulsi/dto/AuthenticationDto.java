package com.seoulsi.dto;

import java.util.Collection;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

public class AuthenticationDto extends UsernamePasswordAuthenticationToken {

	
	private MemberDto user;
//	private List<MenuDto> menu;
	
	public MemberDto getUser() {
		return this.user;
	}
	public void setUser(MemberDto user) {
		this.user = user;
	}
//	
//	public MemberDto getMenu() {
//		return this.user;
//	}
//	public void setMenu(List<MenuDto> menu) {
//		this.menu = menu;
//	}
	
	public AuthenticationDto(Object principal, Object credentials, Collection<? extends GrantedAuthority> authorities, MemberDto user) {
		super(principal, credentials, authorities);
		// TODO Auto-generated constructor stub
		this.user=user;
	}

	
	
}
