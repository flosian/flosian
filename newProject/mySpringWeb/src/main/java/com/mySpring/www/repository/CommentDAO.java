package com.mySpring.www.repository;

import java.util.List;

import com.mySpring.www.domain.CommentVO;

public interface CommentDAO {

	int insert(CommentVO cvo);

	List<CommentVO> getList(long bno);

	int update(CommentVO cvo);

	int delete(long cno);

}
