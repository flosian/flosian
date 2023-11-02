package com.mySpring.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mySpring.www.domain.BoardVO;
import com.mySpring.www.domain.PagingVO;
import com.mySpring.www.repository.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO bdao;

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		return bdao.getList(pgvo);
	}

	@Override
	public BoardVO getDetail(long bno) {
		bdao.setReadCount(bno, 1);
		return bdao.getDetail(bno);
	}

	@Override
	public int register(BoardVO bvo) {
		return bdao.insert(bvo);
	}

	@Override
	public int modify(BoardVO bvo) {
		bdao.setReadCount(bvo.getBno(), -2);
		return bdao.update(bvo);
	}

	@Override
	public int remove(long bno) {
		return bdao.delete(bno);
	}

	@Override
	public int getTotalCnt(PagingVO pgvo) {
		return bdao.getTotalCnt(pgvo);
	}

}
