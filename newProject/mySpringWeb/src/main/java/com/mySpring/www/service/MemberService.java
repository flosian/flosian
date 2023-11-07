package com.mySpring.www.service;

import java.util.List;

import com.mySpring.www.security.MemberVO;

public interface MemberService {

	boolean updateLastLogin(String authEmail);

	int register(MemberVO mvo);

	List<MemberVO> getList();

	MemberVO getDetail(String email);

}
