package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.repository.BoardDAO;
import com.myweb.www.repository.FileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO bdao;
	
	@Inject
	private FileDAO fdao;

//	@Override
//	public int register(BoardVO bvo) {
//		log.info("register check 2");
//		return bdao.insert(bvo);
//	}

	@Override
	public List<BoardVO> getList(PagingVO pagingVO) {
		log.info("list check 2");
		return bdao.getList(pagingVO);
	}

	@Override
	public BoardVO getDetail(long bno) {
		log.info("detail check 2");
		bdao.readCount(bno, 1);
		return bdao.getDetail(bno);
	}

//	@Override
//	public int modify(BoardVO bvo) {
//		log.info("modify check 2");
//		bdao.readCount(bvo.getBno(), -2);
//		return bdao.update(bvo);
//	}

	@Override
	public int remove(long bno) {
		log.info("remove check 2");
		return bdao.delete(bno);
	}

	@Override
	public int getTotalCount(PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return bdao.getTotalCount(pagingVO);
	}

	@Override
	public int register(BoardDTO bdto) {
		// bvo, flist 가져와서 각자 db에 저장
		// 기존 메서드 활용
		int isUp = bdao.insert(bdto.getBvo()); // bno 등록
		if(bdto.getFlist() == null) {
			isUp *= 1;
			return isUp;
		}
		
		// bvo insert 후, 파일도 있다면...
		if(isUp > 0 && bdto.getFlist().size() > 0) {
			long bno = bdao.selectOneBno(); // 가장 마지막에 등록된 bno
			// 모든 파일에 bno set
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isUp *= fdao.insertFile(fvo);
			}
		}
		return 0;
	}

	@Override
	public List<FileVO> getFile(long bno) {
		// TODO Auto-generated method stub
		return fdao.getAllFile(bno);
	}

	@Override
	public int removeFile(String uuid) {
		// TODO Auto-generated method stub
		return fdao.removeFile(uuid);
	}

	@Override
	public int modify(BoardDTO bdto) {
		bdao.readCount(bdto.getBvo().getBno(), -2);
		int isMod = bdao.update(bdto.getBvo());
		if(bdto.getFlist() == null) {
			isMod *= 1;
			return isMod;
		}
		if(isMod > 0 && bdto.getFlist().size() > 0) {
			long bno = bdto.getBvo().getBno();
			for(FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);
				isMod *= fdao.insertFile(fvo);
			}
		}
		return 0;
	}
	
}
