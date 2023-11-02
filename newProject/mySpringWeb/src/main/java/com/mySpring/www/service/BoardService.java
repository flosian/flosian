package com.mySpring.www.service;

import java.util.List;

import com.mySpring.www.domain.BoardVO;
import com.mySpring.www.domain.PagingVO;

public interface BoardService {

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(long bno);

	int register(BoardVO bvo);

	int modify(BoardVO bvo);

	int remove(long bno);

	int getTotalCnt(PagingVO pgvo);

}
