package kr.co.bcd.member.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.bcd.common.controller.SessionManageController;
import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.member.model.service.MemberServiceImpl;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberServiceImpl memberService;

	@Autowired
	private SessionManageController sessionManage;
	
	@Autowired 
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	
	// 닉네임 중복여부 (ajax)
	@RequestMapping("/nicknameCheck.do")
	@ResponseBody // HTTP body에 return 값을 응답으로 보냄 
	public String nicknameCheck(Member member) {
		int result = memberService.nicknameCheck(member.getNickname());
		if (result > 0 ) {
			return "failed";
		}else {
			return "success";
		}
	}
	
	
//	public void nicknameCheck(HttpSession session, Model model, Member member, HttpServletResponse response)
//			throws IOException {
//		String nickname = member.getNickname();
//		System.out.println(nickname);
//		int result = memberService.nicknameCheck(nickname);
//		System.out.println(result);
//
//		PrintWriter out = response.getWriter();
//
//		if (result == 0) {
//			out.print(result);
//			return;// 가입가능
//		} else {
//			out.print(result);
//			return;// 가입불가
//		}
//
//	}

	
	// 아이디 중복여부 (ajax)
	@RequestMapping("/idCheck.do")
	public void idCheck(HttpSession session, Model model, Member member, HttpServletResponse response)
			throws IOException {
		String id = member.getId();
		
		int result = memberService.idCheck(id);
		

		PrintWriter out = response.getWriter();

		if (result == 0) {
			out.print(result);
			return;// 가입가능
		} else {
			out.print(result);
			return;// 가입불가
		}

	}
	
	
	// 마이페이지
	@RequestMapping("/mypage.do")
	public String mypage(HttpSession session, Model model) {
			
		if (session.getAttribute("memberIdx") == null ) {
		
			sessionManage.setSessionMsg("로그인이 필요한 페이지입니다.", "error", session);			
			return "redirect:/member/home.do";
		
		} else {
			
			Member member = memberService.selectMember((int)session.getAttribute("memberIdx"));
			System.out.println("memberContoroller mypage memberIdx:" + member.getIdx());			
			model.addAttribute("member", member);	
			return "member/setting";	
		}	
	}	
	
	// 마이페이지 (비로그인 회원 홈으로 이동)
	@RequestMapping("/home.do")
	public String home(HttpSession session, Model model) {

		String msg = (String)session.getAttribute("msg");
		String status = (String)session.getAttribute("status");

		model.addAttribute("msg", msg);
		model.addAttribute("status", status);

		session.removeAttribute("msg");
		session.removeAttribute("status");
		
		return "home";		
	}	
	
	
	// 회원정보 수정
	@RequestMapping("/updateProfile.do")
	public String updateProfile(HttpSession session, Model model, Member member) {	
		 //memberService.updateProfile(member);
		return "member/mypage.do";
	}

	// 일반로그인
	@GetMapping("/login.do")
	public String login(HttpSession session) {
		// 임시 회원번호 (test)
		int m_idx = 17;
		session.setAttribute("memberIdx", m_idx);
		// 로그인서비스 구현중
		// int m_idx = memberService.loginMember(id,pwd);
		return "redirect:/member/mypage.do";
	}
	
	// 로그아웃
	@RequestMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
		session.invalidate();		
		return "forward:/board/list.do";
	}
	

	// 휴대폰인증 BCD회원가입 
	@RequestMapping("/phoneJoin.do")
	public String phoneJoin(HttpSession session, Member member, Model model) {
		
		String nickname = member.getNickname();
		String id = member.getId();
		String password = member.getPwd();
				
					
		String nicknameRegex = "^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$"; 
		String idRegex = "^(?=.*[a-zA-Z0-9])[a-zA-Z0-9]{2,16}$"; 
		String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$"; 
		
		// nickname 2차 검증
		String nicknameOverlapCheck = nicknameCheck(member);
		if(password.matches(passwordRegex) && nicknameOverlapCheck.equals("success") && id.matches(idRegex) && nickname.matches(nicknameRegex)) {
			//패스워드 암호화
			String pwd = bCryptPasswordEncoder.encode(member.getPwd()); 
			member.setPwd(pwd);
		
			//회원가입
			int result = memberService.memberPhoneJoin(member);
				if (result > 0) {			
					//회원가입 후 바로 회원번호 가져오기
					int m_idx = member.getIdx();
					session.setAttribute("memberIdx", m_idx);
					// 이전페이지로 이동
					String currentUrl = (String) session.getAttribute("currentUrl");
					String withoutJsp = currentUrl.replace(".jsp", "");
					String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제
					session.setAttribute("previousUrl", previousUrl);
					model.addAttribute("welcomeModal", "welcomeModal");
					return previousUrl;
					
				}else {
				
					return "common/error";
				}	
		}
		
		return "";  	
	}
	
	
	
	
	
// 소셜로그인회원 BCD회원가입 (닉네임 포함 -> 가입완료)
	@RequestMapping("/snsJoin.do")
	public String snsJoin(HttpSession session, Member member, Model model) {

		// 닉네임 & ID(=email) 중복체크 (백엔드)
		int nicknameOverlapCheck = memberService.nicknameCheck(member.getNickname());
		//int idOverlapCheck = memberService.checkId(member.getSnsId()); // snsId는 이메일로 중복될수 있음..(카카오 & 네이버) 
		//if (nicknameOverlapCheck == 0 && idOverlapCheck == 0) {
		if (nicknameOverlapCheck == 0) {
			memberService.memberJoin(member);

			// db에서 만들자마자 keyProperty 가져와 session에 심어주기
			int m_idx = member.getIdx();
			session.setAttribute("memberIdx", m_idx);

			// 이전페이지로 이동
			String currentUrl = (String) session.getAttribute("currentUrl");
			String withoutJsp = currentUrl.replace(".jsp", "");
			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제
			session.setAttribute("previousUrl", previousUrl);
			model.addAttribute("welcomeModal", "welcomeModal");

			return previousUrl;

		} else {

			return "common/error";
		}

	}


	// 자동로그인 시 활용 (Json -> Map)
	private final RestTemplate restTemplate;

	public MemberController(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

		
	// 네이버 로그인 access_token 발행 + 프로필 정보 가져오기
	@RequestMapping("/loginResult")
	public String naversuccess(HttpServletRequest request, Model model, HttpSession session) throws Exception {

		String clientId = "VH0vES0K33odVfIDgWKi"; // 네이버 애플리케이션 클라이언트 아이디값
		String clientSecret = "J0x9GEZhi8"; // 네이버 애플리케이션 클라이언트 시크릿값
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://localhost:8080/user/loginResult", "UTF-8");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;

		// 네이버 인증 서버로부터 access_token 요청
		Map<String, Object> json = restTemplate.getForObject(apiURL, Map.class);
		String accessToken = (String) json.get("access_token");

		// 네이버 API를 통해 사용자 프로필 정보 조회
		Member member = getNaverProfile(accessToken);
System.out.println("memberContoroller Naver:" + member.getSnsId());	
System.out.println("memberContoroller Naver:" + member.getSnsType());	
		// 가입여부 확인 (이메일로)
		int result = memberService.checkEmail(member);
		if (result <= 0) {
System.out.println("memberContoroller Naver 겨과:" + result);	
			// 사용자 정보 보내줘서 나머지 회원가입 마무리 시키기
			model.addAttribute("member", member);

			// 사용자 이전 URL 가져오기
			String currentUrl = (String) session.getAttribute("currentUrl");
			String withoutJsp = currentUrl.replace(".jsp", "");
			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제
			session.setAttribute("previousUrl", previousUrl);

			// 소셜로그인(회원가입) 마무리 위한 닉네임 모달 띄우기용
			model.addAttribute("snsLogin", "snsLogin");

			return previousUrl; // BCD 닉네임 정하는 모달로 이동
			
		} else { // 이미 회원인 경우

			String currentUrl = (String) session.getAttribute("currentUrl");
			String withoutJsp = currentUrl.replace(".jsp", "");
			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제
			session.setAttribute("previousUrl", previousUrl);

			// 멤버 idx 가져오기
			int m_idx = memberService.checkIdx(member.getSnsId());
			session.setAttribute("memberIdx", m_idx);
			return previousUrl;
		}

	}

	// 발행된 access_token을 활용해 사용자 정보 가져오기
	private Member getNaverProfile(String accessToken) throws Exception {

		String profileApiUrl = "https://openapi.naver.com/v1/nid/me";

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<?> httpEntity = new HttpEntity<>(headers);

		ResponseEntity<Map> responseEntity = restTemplate.exchange(profileApiUrl, HttpMethod.GET, httpEntity,
				Map.class);

		Map<String, Object> responseMap = responseEntity.getBody();

		// 사용자 프로필 정보 추출
		Map<String, Object> naverUserInfo = (Map<String, Object>) responseMap.get("response");
		String naverId = (String) naverUserInfo.get("email");
		String naverPhone = (String) naverUserInfo.get("mobile");
		String naverNickname = (String) naverUserInfo.get("nickname");

		// Member 클래스에 사용자 프로필 정보 매핑
		Member member = new Member();
		member.setSnsId(naverId);
		member.setPhone(naverPhone);
		member.setNickname(naverNickname);
		member.setSnsType("Naver"); // 카카오와 구분

		return member;

	}
	

//카카오 API 로그인
	// 카카오로그인 사용자 코드 받기
	@RequestMapping("/kakaoLogin")
	public String kakaosuccess(@RequestParam(value = "code", required = false) String code, Model model, HttpSession session)
			throws Exception {

		String authorize_code = code;
		String clientId = "0a1b520b1d14379b7230e168bd69de63";
		String clientSecret = "HhBt7HHtyHQxD96hzwEfY0S7Ls0Evznm";
		String redirect_uri = "http://localhost:8080/member/kakaoLogin";

		// 카카오 엑세스 토큰 받기
		String reqURL = "https://kauth.kakao.com/oauth/token";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", clientId);
		params.add("redirect_uri", redirect_uri);
		params.add("code", code);
		params.add("client_secret", clientSecret);
		params.add("scope", "account_email"); // 사용자 이메일 정보에 대한 동의 요청

		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
		ResponseEntity<Map> response = restTemplate.exchange(reqURL, HttpMethod.POST, request, Map.class);

		Map<String, Object> json = response.getBody();
		String accessToken = (String) json.get("access_token");

		Member member = getKakaoProfile(accessToken);
System.out.println("memberContoroller kakao:" + member.getSnsId());	
System.out.println("memberContoroller kakao :" + member.getSnsType());			
		int result = memberService.checkEmail(member);
System.out.println("memberContoroller kakao 가입여부:" + result);		

		if (result <= 0) {
			// 사용자 정보 보내주숴 나머지 회원가입 마무리 시키기
			model.addAttribute("member", member);
System.out.println("memberContoroller kakao 가입여부:(reuslt <= 0 케이스)" + result);	
			// 사용자 이전 URL 가져오기
			String currentUrl = (String) session.getAttribute("currentUrl");
			String withoutJsp = currentUrl.replace(".jsp", "");
			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제
			session.setAttribute("previousUrl", previousUrl);

			// 소셜로그인(회원가입) 마무리 위한 닉네임 모달 띄우기용
			model.addAttribute("snsLogin", "snsLogin");

			return previousUrl; // BCD 닉네임 정하는 모달로 이동
			
		} else { // 이미 회원인 경우
					// 이전페이지로 이동
			System.out.println("memberContoroller kakao 가입여부:(reuslt <= 0 케이스)" + result);	
			String currentUrl = (String) session.getAttribute("currentUrl");
			String withoutJsp = currentUrl.replace(".jsp", "");
			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제
			session.setAttribute("previousUrl", previousUrl);

			// 멤버 idx 가져오기
			int m_idx = memberService.checkIdx(member.getSnsId());
			session.setAttribute("memberIdx", m_idx);
			return previousUrl;
		}
	}

	// 발행된 access_token을 활용해 사용자 정보 가져오기
	private Member getKakaoProfile(String accessToken) throws Exception {
		  String profileApiUrl = "https://kapi.kakao.com/v2/user/me";

		    HttpHeaders headers = new HttpHeaders();
		    headers.set("Authorization", "Bearer " + accessToken);
		    headers.setContentType(MediaType.APPLICATION_JSON);

		    HttpEntity<?> httpEntity = new HttpEntity<>(headers);

		    ResponseEntity<Map> responseEntity = restTemplate.exchange(profileApiUrl, HttpMethod.GET, httpEntity,
		            Map.class);

		    Map<String, Object> responseMap = responseEntity.getBody();

		    // 사용자 프로필 정보 추출
		    Map<String, Object> kakaoUserInfo = (Map<String, Object>) responseMap.get("kakao_account");
		    String kakaoId = (String) kakaoUserInfo.get("email");

		    // Member 클래스에 사용자 프로필 정보 매핑
		    Member member = new Member();
		    member.setSnsId(kakaoId); // email
		    member.setSnsType("Kakao"); // 네이버와 구분

		    return member;

	}


}
