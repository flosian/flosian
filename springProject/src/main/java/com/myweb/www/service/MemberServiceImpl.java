package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.repository.MemberDAO;
import com.myweb.www.security.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO mdao;

	@Transactional
	@Override
	public int register(MemberVO mvo) {
		int isOk = mdao.insertMember(mvo);
		return mdao.insertAuthInit(mvo);
	}

	@Override
	public boolean updateLastLogin(String authEmail) {

		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}

	@Transactional
	@Override
	public List<MemberVO> getList() {
		List<MemberVO> list = mdao.getList();
		for(MemberVO mvo : list) {
			mvo.setAuthList(mdao.selectAuths(mvo.getEmail()));
		}
		return list;
	}

	@Override
	public MemberVO getDetail(String email) {
		return mdao.getDetail(email);
	}

	@Override
	public int modify(MemberVO mvo) {
		return mdao.update(mvo);
	}

	@Override
	public int modifiIfPwdEmpty(MemberVO mvo) {
		return mdao.updatePwdEmpty(mvo);
	}

	@Override
	public int remove(String email) {
		return mdao.remove(email);
	}
}
