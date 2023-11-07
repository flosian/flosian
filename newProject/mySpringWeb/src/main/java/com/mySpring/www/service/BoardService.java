package com.mySpring.www.service;

import java.util.List;

import com.mySpring.www.domain.BoardDTO;
import com.mySpring.www.domain.BoardVO;
import com.mySpring.www.domain.FileVO;
import com.mySpring.www.domain.PagingVO;

public interface BoardService {

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(long bno);

	int register(BoardDTO bdto);

	int modify(BoardDTO bdto);

	int remove(long bno);

	int getTotalCnt(PagingVO pgvo);

	List<FileVO> getFile(long bno);

	int delFile(String uuid);

}
