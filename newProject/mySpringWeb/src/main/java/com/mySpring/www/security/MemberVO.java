package com.mySpring.www.security;

import lombok.ToString;

import lombok.Setter;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {

	private String email;
	private String pwd;
	private String nickName;
	private String regAt;
	private String lastLogin;
	private List<AuthVO> authList;
	
}
