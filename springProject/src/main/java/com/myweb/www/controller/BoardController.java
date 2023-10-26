package com.myweb.www.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.FileHandler;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/*")
public class BoardController {
	// 폴더명 : board / mapping : board
	// mapping => /board/register
	// 목적지 => /board/register
	// 이름을 맞추면 return "/board/register" 적지 않아도 void로 이동 가능
	
	@Inject
	private BoardService bsv;
	
//	@Inject
//	private BoardDTO bdto;
	
	@Inject
	private FileHandler fh;
	
	@GetMapping("/register")
	public void boardRegisterGet() {
		log.info("register check 1");
	}
	
	@PostMapping("/register")
	public String register(Model model, BoardVO bvo, RedirectAttributes re,
			@RequestParam(name="files", required = false) MultipartFile[] files) {
		if(bvo.getTitle() == null || bvo.getTitle() == "" || bvo.getContent() == null || bvo.getContent() == "") {
			model.addAttribute("checkEmpty", 1);
			return "/board/register";
		}else {
			log.info(">>>> bvo >> files >> "+bvo + " "+files);
			List<FileVO> flist = new ArrayList<>();
			// file upload handler 생성
			if(files[0].getSize() > 0) {
				flist = fh.uploadFiles(files);
			}
			
			int isOk = bsv.register(new BoardDTO(bvo, flist));
			re.addFlashAttribute("isOk", isOk);
			log.info("등록 "+(isOk > 0 ? "OK" : "Fail"));
			
			return "redirect:/board/list";			
		}
	}
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		List<BoardVO> list = bsv.getList();
//		model.addAttribute("list",list);
//	}
	
	// paging 추가
	@GetMapping("/list")
	public void list(Model model, PagingVO pagingVO) {
		log.info(">>>>> pagingVO >> "+pagingVO);
		model.addAttribute("list", bsv.getList(pagingVO));
		
		// 페이징 처리
		// 총 페이징 갯수 totalCount (검색 포함)
		int totalCount = bsv.getTotalCount(pagingVO);
		PagingHandler ph = new PagingHandler(pagingVO, totalCount);
		model.addAttribute("ph", ph);
		
	}
	
	
	@GetMapping("/detail")
	public void detail(Model model, @RequestParam("bno")long bno) {
		BoardDTO bdto = new BoardDTO();

		BoardVO bvo = bsv.getDetail(bno);
		bdto.setBvo(bvo);
		
		if(bsv.getFile(bno) != null) {
			bdto.setFlist(bsv.getFile(bno));
			log.info(">>>>>>> bdto >>>>> "+bdto);
		}
		model.addAttribute("bvo", bdto.getBvo());
		model.addAttribute("file", bdto.getFlist());
	}
	
	@GetMapping("/modify")
	public void modify(Model model, @RequestParam("bno")long bno) {
		BoardDTO bdto = new BoardDTO();
		BoardVO bvo = bsv.getDetail(bno);

		bdto.setBvo(bvo);
		
		if(bsv.getFile(bno) != null) {
			bdto.setFlist(bsv.getFile(bno));
			log.info(">>>>>>> bdto >>>>> "+bdto);
		}
		model.addAttribute("bvo", bdto.getBvo());
		model.addAttribute("file", bdto.getFlist());
		
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO bvo, RedirectAttributes re,
			@RequestParam(name="files", required = false) MultipartFile[] files) {
		
		log.info(">>>> bvo >> files >> "+bvo + " "+files);
		List<FileVO> flist = new ArrayList<>();
		
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		
		int isOk = bsv.modify(new BoardDTO(bvo, flist));
		log.info("수정 "+(isOk > 0 ? "OK" : "Fail"));
		re.addFlashAttribute("isMod", isOk);
		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno")long bno, RedirectAttributes re) {
		int isDel = bsv.remove(bno);
		log.info("삭제 "+(isDel > 0 ? "OK" : "Fail"));
		re.addFlashAttribute("isDel", isDel);
		return "redirect:/board/list";
	}
	
	@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid) {
		log.info(">>>>>>>>>>> uuid >> "+uuid);
		int isOk = bsv.removeFile(uuid);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
