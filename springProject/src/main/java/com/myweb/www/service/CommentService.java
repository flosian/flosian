package com.myweb.www.service;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;

public interface CommentService {

	int post(CommentVO cvo);

//	List<CommentVO> getList(long bno);

	int remove(long bno, long cno);

	int modify(CommentVO cvo);

//	DAO가 아니면 @Param 안 붙여도 됨
	PagingHandler getList(long bno, PagingVO pgvo);

}
