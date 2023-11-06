package com.mySpring.www.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mySpring.www.domain.BoardDTO;
import com.mySpring.www.domain.BoardVO;
import com.mySpring.www.domain.FileVO;
import com.mySpring.www.domain.PagingVO;
import com.mySpring.www.handler.FileHandler;
import com.mySpring.www.handler.PagingHandler;
import com.mySpring.www.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	private BoardService bsv;
	
	@Inject
	private FileHandler fh;
	
	@GetMapping("/register")
	public void reg() {}
	
	@PostMapping("/register")
	public String regPost(BoardVO bvo, @RequestParam(name = "files", required = false) MultipartFile[] files) {
		List<FileVO> flist = new ArrayList<>();
		log.info(">>>>>>>> bvo >>> files >>> "+bvo+ " "+files);
		
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		
		int isOk = bsv.register(new BoardDTO(bvo, flist));
		log.info("등록 "+(isOk > 0 ? "OK":"Fail"));
		return "redirect:/board/list";
	}
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		List<BoardVO> list = bsv.getList();
//		model.addAttribute("list", list);
//	}
	
	@GetMapping("/list")
	public void list(Model model, PagingVO pgvo) {
		List<BoardVO> list = bsv.getList(pgvo);
		model.addAttribute("list", list);
		
		int totalCount = bsv.getTotalCnt(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		model.addAttribute("ph", ph);
	}
	
	@GetMapping("/detail")
	public void detail(Model model, @RequestParam("bno")long bno) {
		BoardDTO bdto = new BoardDTO();
		BoardVO bvo = bsv.getDetail(bno);
		bdto.setBvo(bvo);
		
		if(bsv.getFile(bno) != null) {
			bdto.setFlist(bsv.getFile(bno));
		}
		
		model.addAttribute("bvo", bdto.getBvo());
		model.addAttribute("flist", bdto.getFlist());
	}
	
	@GetMapping("/modify")
	public void mod(Model model, @RequestParam("bno")long bno) {
		BoardDTO bdto = new BoardDTO();
		BoardVO bvo = bsv.getDetail(bno);
		bdto.setBvo(bvo);
		
		if(bsv.getFile(bno) != null) {
			bdto.setFlist(bsv.getFile(bno));
		}
		
		model.addAttribute("bvo", bdto.getBvo());
		model.addAttribute("flist", bdto.getFlist());
	}
	
	@PostMapping("/modify")
	public String modPost(BoardVO bvo, RedirectAttributes re,
			@RequestParam(name = "files", required = false) MultipartFile[] files) {
		List<FileVO> flist = new ArrayList<>();
		log.info(">>>>>>>> bvo >>> files >>> "+bvo+ " "+files);
		
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		
		int isMod = bsv.modify(new BoardDTO(bvo, flist));
		log.info("수정 "+(isMod > 0 ? "OK":"Fail"));
		re.addFlashAttribute("isMod", isMod);
		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno")long bno, RedirectAttributes re) {
		int isDel = bsv.remove(bno);
		log.info("삭제 "+(isDel > 0 ? "OK":"Fail"));
		re.addFlashAttribute("isDel", isDel);
		return "redirect:/board/list";
	}
	
}
