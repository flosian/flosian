package com.mySpring.www.service;

import java.util.List;

import com.mySpring.www.domain.CommentVO;

public interface CommentService {

	int post(CommentVO cvo);

	List<CommentVO> getList(long bno);

	int modify(CommentVO cvo);

	int remove(long cno);

}
