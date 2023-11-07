package com.mySpring.www.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mySpring.www.security.MemberVO;
import com.mySpring.www.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member/**")
@Controller
public class MemberController {

	@Inject
	private BCryptPasswordEncoder bcEncoder;
	
	@Inject
	private MemberService msv;
	
	@GetMapping("/register")
	public void reg() {}
	
	@PostMapping("/register")
	public String regPost(MemberVO mvo) {
		log.info(">>>> mvo >>>> "+mvo);
		mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
		int isOk = msv.register(mvo);
		log.info("등록 "+(isOk > 0 ? "성공":"실패"));
		
		return "index";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request, RedirectAttributes re) {
		log.info("로그인 실패~~~~");
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		return "redirect:/member/login";
	}
	
	@GetMapping("/list")
	public void list(Model m) {
		List<MemberVO> list = msv.getList();
		m.addAttribute("list", list);
	}
	
	@GetMapping("/detail")
	public void detail(Model m, @RequestParam("email")String email) {
		MemberVO mvo = msv.getDetail(email);
		m.addAttribute("mvo", mvo);
	}
	
}
