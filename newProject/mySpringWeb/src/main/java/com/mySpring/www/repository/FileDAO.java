package com.mySpring.www.repository;

import java.util.List;

import com.mySpring.www.domain.FileVO;

public interface FileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getAllFile(long bno);

	int delFile(String uuid);

}
