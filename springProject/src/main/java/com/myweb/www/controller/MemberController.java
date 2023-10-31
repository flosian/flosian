package com.myweb.www.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.security.MemberVO;
import com.myweb.www.service.MemberService;

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
	public void register() {}
	
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		log.info(">>>>> mvo >>> "+mvo);
		mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
		int isOk = msv.register(mvo);
		return "index";
	}

	@GetMapping("/login")
	public void loginGet() {}
	
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request, RedirectAttributes re) {
		// 로그인 실패시 다시 로그인 페이지로 돌아와 오류 메시지 전송
		// 다시 로그인 유도
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
	
	@GetMapping("/modify")
	public void modifyGet(Model m, MemberVO mvo) {
		m.addAttribute("mvo", mvo);
	}

	@PostMapping("/modify")
	public String modifyPost(Model m, MemberVO mvo, HttpServletRequest req, HttpServletResponse res) {
		log.info(">>>>>>>>>>>> mvo >>>>>>>> "+mvo);
		int isOk = 3;
		if(mvo.getPwd().isEmpty()) {
			isOk = msv.modifiIfPwdEmpty(mvo);
		}else {
			mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
			isOk = msv.modify(mvo);
		}
		log.info("isOk >>>>>>>>>>>>>>"+isOk);
		logout(req, res);
		m.addAttribute("isOk", isOk);
		return "/member/login";
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("email")String email, HttpServletRequest req, HttpServletResponse res) {
		int isOk = msv.remove(email);
		log.info("탈퇴 "+(isOk > 0 ? "OK" : "Fail"));
		logout(req, res);
		return "/member/login";
	}
	
	private void logout(HttpServletRequest req, HttpServletResponse res) {
		Authentication authentication = SecurityContextHolder
				.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(req, res, authentication);
	}
}
