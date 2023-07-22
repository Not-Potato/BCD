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
	
	
	//회원번호로 회원정보 조회 (profile 수정 시 활용)
	@RequestMapping("/mypage.do")
	public String settingProfile (HttpSession session, Model model) {
		Member member = memberService.selectMember((int)session.getAttribute("memberIdx"));
		model.addAttribute("member", member);
		return "member/setting";
	}
	
	//회원정보 수정
	@RequestMapping("/changeProfile.do")
	public String updateProfile (HttpSession session, Model model, Member member) {
		member.setIdx((int)session.getAttribute("memberIdx"));
		memberService.updateProfile(member);
		return "/home";
	}
	
	//회원가입 양식으로 이동
	@RequestMapping("/join.do")
	public String registerForm (HttpSession session, Model model) {	
		return "member/register";	
	}
	
	//회원가입 
//	@PostMapping("/register.do") 
//	public String register(Member member, HttpSession session) {
//		 
//		//String password = member.getPwd(); 
//		//String passwordChk = member.getPwdChk(); 
//		//String email = member.getPhone();  
//		//String nickname = member.getNickname(); //중복검사필요 
//		//String id = member.getId(); //중복검사필요
//		
//		//String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{6,20}$"; // 비밀번호 유효성 검사
//		
//		memberService.register(member);
//		
//		return"";
//	}
//	
	//멤버로그인
	@RequestMapping("/login.do")
	public String login(HttpSession session, Model model) {
		// 임시 회원번호 (test)
		int m_idx = 6;
		session.setAttribute("memberIdx", m_idx);
		// 로그인서비스 구현중
		// int m_idx = memberService.loginMember(id,pwd);
		return "redirect:/member/mypage.do";
	}
	
}
