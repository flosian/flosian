package com.mySpring.www.repository;

import java.util.List;

import com.mySpring.www.security.AuthVO;
import com.mySpring.www.security.MemberVO;

public interface MemberDAO {
	
	int insertMember(MemberVO mvo);

	int insertAuthInit(MemberVO mvo);

	int updateLastLogin(String authEmail);

	MemberVO selectEmail(String username);

	List<AuthVO> selectAuths(String username);

	List<MemberVO> getList();

	MemberVO getDetail(String email);

}
