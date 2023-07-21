package kr.co.bcd.member.controller;


import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.member.model.service.MemberServiceImpl;


@Controller
@RequestMapping("/member") 
public class MemberController {
	
	@Autowired
	MemberServiceImpl memberService;
	
	
	//회원가입 양식으로 이동
	//@GetMapping("/registerForm.do")
	@GetMapping("/register.do")
	public String registerForm (HttpSession session, Model model) {
		
		
		return "member/register";
	}
	
	//회원가입 
	@PostMapping("/register.do") 
	public String register(Member member, HttpSession session) {
		 
		//String password = member.getPwd(); 
		//String passwordChk = member.getPwdChk(); 
		//String email = member.getPhone();  
		//String nickname = member.getNickname(); //중복검사필요 
		//String id = member.getId(); //중복검사필요
		
		//String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{6,20}$"; // 비밀번호 유효성 검사
		
		memberService.register(member);
		
		return"";
	}
	
}
