package com.mySpring.www.handler;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.mySpring.www.domain.FileVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
public class FileHandler {

	private final String UP_DIR = "D:\\_myweb\\_java\\fileupload";
	
	public List<FileVO> uploadFiles(MultipartFile[] files){
		List<FileVO> flist = new ArrayList<>();
		
		LocalDate date = LocalDate.now();
		String today = date.toString(); // 2023-10-24
		today = today.replace("-", File.separator);
		
		File folders = new File(UP_DIR, today);
		
		// 폴더 생성
		if(!folders.exists()) {
			folders.mkdirs();
		}
		
		// file 객체에 대한 설정
		for(MultipartFile file : files) {
			FileVO fvo = new FileVO();
			fvo.setSaveDir(today);
			fvo.setFileSize(file.getSize());
			String originalFileName = file.getOriginalFilename();
			log.info(">>>>> original >> "+originalFileName);
			String fileName = originalFileName.substring(
					originalFileName.lastIndexOf(File.separator)+1);
			fvo.setFileName(fileName);
			
			UUID uuid = UUID.randomUUID();
			fvo.setUuid(uuid.toString());
			// 기본 FileVO 생성 ----------------------
			
			// 디스크에 저장할 파일 객체 생성 -----------
			String fullFileName = uuid.toString()+"_"+fileName;
			File storeFile = new File(folders, fullFileName);
			// file 객체가 저장되려면 첫 경로부터 다 설정되어 있어야 함
			
			try {
				file.transferTo(storeFile); // 저장
				// 썸네일 생성
				if(isImageFile(storeFile)) {
					fvo.setFileType(1);
					
					File thumbNail = new File(folders,
							uuid.toString()+"_th_"+fileName);
					Thumbnails.of(storeFile).size(75, 75).toFile(thumbNail);
				}
				
			} catch (Exception e) {
				log.debug(">>>>> file 생성 오류");
				e.printStackTrace();
			}
			
			flist.add(fvo);
			
		}
	
		return flist;
	}
	
	private boolean isImageFile(File storeFile) throws IOException {
		// mimeType 뜻 : 멀티미디어 타입
		String mimeType = new Tika().detect(storeFile);
		return mimeType.startsWith("image") ? true : false;
	}
	

}
