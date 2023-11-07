package com.mySpring.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mySpring.www.repository.MemberDAO;
import com.mySpring.www.security.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO mdao;

	@Override
	public boolean updateLastLogin(String authEmail) {
		// TODO Auto-generated method stub
		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}

	@Override
	public int register(MemberVO mvo) {
		int isOk = mdao.insertMember(mvo);
		return mdao.insertAuthInit(mvo);
	}

	@Override
	public List<MemberVO> getList() {
		// TODO Auto-generated method stub
		return mdao.getList();
	}

	@Override
	public MemberVO getDetail(String email) {
		// TODO Auto-generated method stub
		return mdao.getDetail(email);
	}
	
	
}
