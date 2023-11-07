package com.mySpring.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mySpring.www.domain.BoardVO;
import com.mySpring.www.domain.PagingVO;

public interface BoardDAO {

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(long bno);

	int insert(BoardVO bvo);

	int update(BoardVO bvo);

	int delete(long bno);

	int getTotalCnt(PagingVO pgvo);

	void setReadCount(@Param("bno") long bno, @Param("cnt") int cnt);

	long selectOneBno();

	void updateCmtCount();

	void updateFileCount();

}
