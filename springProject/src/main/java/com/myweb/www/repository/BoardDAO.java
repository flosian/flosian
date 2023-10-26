package com.myweb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList(PagingVO pagingVO);

	BoardVO getDetail(long bno);

	int update(BoardVO bvo);

	int delete(long bno);

	int getTotalCount(PagingVO pagingVO);

	void readCount(@Param("bno") long bno, @Param("cnt") int cnt);

	long selectOneBno();

	void updateCmtCnt();

	void updateFileCnt();

}
