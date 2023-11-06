package com.mySpring.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mySpring.www.domain.BoardDTO;
import com.mySpring.www.domain.BoardVO;
import com.mySpring.www.domain.FileVO;
import com.mySpring.www.domain.PagingVO;
import com.mySpring.www.repository.BoardDAO;
import com.mySpring.www.repository.FileDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO bdao;
	
	@Inject
	private FileDAO fdao;

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		return bdao.getList(pgvo);
	}

	@Transactional
	@Override
	public BoardVO getDetail(long bno) {
		bdao.setReadCount(bno, 1);
		return bdao.getDetail(bno);
	}

	@Transactional
	@Override
	public int register(BoardDTO bdto) {
		int isUp = bdao.insert(bdto.getBvo());
		if(bdto.getFlist() == null) {
			isUp *= 1;
		}
		
		if(isUp > 0 && bdto.getFlist().size() > 0) {
			long bno = bdao.selectOneBno();
			
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isUp *= fdao.insertFile(fvo);
			}
		}
		
		return isUp;
	}

	@Transactional
	@Override
	public int modify(BoardDTO bdto) {
		bdao.setReadCount(bdto.getBvo().getBno(), -2);
		int isMod = bdao.update(bdto.getBvo());
		if(bdto.getFlist() == null) {
			isMod *= 1;
		}
		
		if(isMod > 0 && bdto.getFlist().size() > 0) {
			long bno = bdto.getBvo().getBno();
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isMod *= fdao.insertFile(fvo);
			}
		}
		
		return isMod;
	}

	@Override
	public int remove(long bno) {
		return bdao.delete(bno);
	}

	@Override
	public int getTotalCnt(PagingVO pgvo) {
		return bdao.getTotalCnt(pgvo);
	}

	@Override
	public List<FileVO> getFile(long bno) {
		// TODO Auto-generated method stub
		return fdao.getAllFile(bno);
	}

}
