package kr.co.bcd.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import kr.co.bcd.common.controller.SessionManageController;
import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.member.model.service.MemberServiceImpl;


@Controller
@RequestMapping("/member") 
public class MemberController {
	
	@Autowired
	MemberServiceImpl memberService;

	
	//닉네임 중복여부 (ajax)
		@RequestMapping("/nicknameCheck.do")
		public void nicknameCheck (HttpSession session, Model model, Member member, HttpServletResponse response) throws IOException {
			String nickname = member.getNickname();
			System.out.println(nickname);
			int result = memberService.nicknameCheck(nickname); 
			System.out.println(result);
			
				PrintWriter out = response.getWriter();
				
				if (result == 0) {
					out.print(result);
					return;//가입가능
				}else {
					out.print(result);
					return;//가입불가
				}
			
		}
		
		
		//회원번호로 회원정보 조회 (profile 수정 시 활용)
		@RequestMapping("/mypage.do")
		public String settingProfile (HttpSession session, Model model) {
			Member member = memberService.selectMember((int)session.getAttribute("memberIdx"));
			model.addAttribute("member", member);
			return "member/setting";
		}
		
		
		
		//회원정보 수정
		@RequestMapping("/updateProfile.do")
		public String updateProfile (HttpSession session, Model model, Member member) {
			//member.setIdx((int)session.getAttribute("memberIdx"));
			//memberService.updateProfile(member);
			return "member/mypage";
		}
		
		
		//회원가입 
//		@PostMapping("/register.do") 
//		public String register(Member member, HttpSession session) {
//			 
//			//String password = member.getPwd(); 
//			//String passwordChk = member.getPwdChk(); 
//			//String email = member.getPhone();  
//			//String nickname = member.getNickname(); //중복검사필요 
//			//String id = member.getId(); //중복검사필요
//			
//			//String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{6,20}$"; // 비밀번호 유효성 검사
//			
//			memberService.register(member);
//			
//			return"";
//		}
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
	

		
//네이버 로그인 API 구현부	
		
		//네이버 자동로그인 시 활용 (Json -> Map) 
		private final RestTemplate restTemplate;
	    public MemberController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
	

		// 네이버 로그인 access_token 발행 후 프로필 정보 가져오기
		@RequestMapping("/loginResult")
		public String naversuccess(HttpServletRequest request, Model model, HttpSession session )throws Exception {	
		      	
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
	            
	            //가입여부 확인 (휴대전화로)
	            
	            	int result = memberService.checkPhone(member.getPhone());
	            	
	            	if (result <= 0 ) {
	            		//사용자 정보 보내주숴 나머지 회원가입 마무리 시키기
	            		model.addAttribute("member", member);
	            	
	                    // 사용자 이전 URL 가져오기
	                    String currentUrl = (String)session.getAttribute("currentUrl");
	                    String withoutJsp = currentUrl.replace(".jsp", "");
	                    String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제                 
	                    session.setAttribute("previousUrl", previousUrl);
	  		
	                    // 모달 JSP 경로를 모델에 추가하여 리턴
	                    model.addAttribute("modalJspPath", "../member/nicknameModal.jsp");	                 
	            		return previousUrl; //BCD 닉네임 정하는 모달로 이동
	            	}
	            	else {
	            		//이전페이지로 이동
	                    String currentUrl = (String)session.getAttribute("currentUrl");
	                    String withoutJsp = currentUrl.replace(".jsp", "");
	                    String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제                 
	                    session.setAttribute("previousUrl", previousUrl);
	                    
	        			// 임시 회원번호 (test)
	        			int m_idx = memberService.checkIdx(member.getPhone());
	        			session.setAttribute("memberIdx", m_idx);
	                    
	            		return previousUrl; //BCD 닉네임 정하는 모달로 이동	
	            	}
	            	
	}
		
		// 발행된 access_token을 활용해 사용자 정보 가져오기	
		private Member getNaverProfile(String accessToken)throws Exception  {
			
		    String profileApiUrl = "https://openapi.naver.com/v1/nid/me";

	        HttpHeaders headers = new HttpHeaders();
	        headers.set("Authorization", "Bearer " + accessToken);
	        headers.setContentType(MediaType.APPLICATION_JSON);

	        HttpEntity<?> httpEntity = new HttpEntity<>(headers);

	        ResponseEntity<Map> responseEntity = restTemplate.exchange(
	                profileApiUrl,
	                HttpMethod.GET,
	                httpEntity,
	                Map.class
	        );

	        Map<String, Object> responseMap = responseEntity.getBody();

	        // 사용자 프로필 정보 추출
	        Map<String, Object> naverUserInfo = (Map<String, Object>) responseMap.get("response");
	        String naverId = (String) naverUserInfo.get("email");
	        String naverPhone = (String) naverUserInfo.get("mobile");
	        String naverNickname = (String) naverUserInfo.get("nickname");
	        
System.out.println("memberController naverId: " + naverId);
System.out.println("memberController naverPhone: " + naverPhone);
System.out.println("memberController naverNickname: " + naverNickname);

	        // Member 클래스에 사용자 프로필 정보 매핑
	        Member member = new Member();
	        member.setSnsId(naverId);
	        member.setPhone(naverPhone);
	        member.setNickname(naverNickname); 
	        member.setSnsType("NAVER"); // 카카오와 구분
	      
	        return member;
	    
	    }
//end of 네이버 로그인 API 구현부		
	
	
}
