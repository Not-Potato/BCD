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
import java.util.Objects;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.bcd.chat.handler.ChatMsgHandler;
import kr.co.bcd.common.aws.S3UploadController;
import kr.co.bcd.common.controller.SessionManageController;
import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.member.model.service.MemberServiceImpl;

import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.MessageService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	private static Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberServiceImpl memberService;

	@Autowired
	private SessionManageController sessionManage;
	
	@Autowired 
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired 
	private MessageController messageController;
	
	@Autowired
	private S3UploadController uploadFile;


	//---------------------소셜로그인 자동로그인 시 활용 (Json -> Map)-----------------//
	private final RestTemplate restTemplate;

	public MemberController(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}
	
	
	//-------------------------- 홈으로 (세션 삭제용)-------------------------------//
	@RequestMapping("/home.do")
	public String home(HttpSession session, Model model) {	
		sessionManage.getSessionMsg(session, model); 
		return "home";		
	}	
	
	
	
	//------------------------ 닉네임 중복여부  (ajax)----------------------------//
	@RequestMapping("/nicknameCheck.do")
	@ResponseBody
	public String nicknameCheck(Member member) {
		int result = memberService.nicknameCheck(member.getNickname());
		if (result > 0 ) {
			return "failed";
		}else {
			return "success";
		}
	}
	
	//------------------------ 아이디 중복여부 (ajax) ----------------------------//
	@RequestMapping("/idCheck.do")
	@ResponseBody
	public String idCheck(Member member)
			throws IOException {	
		int result = memberService.idCheck(member.getId());		
		if (result > 0 ) {
			return "failed";
		}else {
			return "success";
		}
	}
	
	
	//------------------------ 마이페이지 접근------------------------------//
	@RequestMapping("/mypage.do")
	public String mypage(HttpSession session, Model model) {
			
		if (session.getAttribute("memberIdx") == null ) {
			sessionManage.setSessionMsg("로그인이 필요한 페이지입니다.", "error", session);			
			return "redirect:/";
		
		} else {
			Member member = memberService.selectMember((int)session.getAttribute("memberIdx"));				
			model.addAttribute("member", member);			
			sessionManage.getSessionMsg(session, model);
			return "member/setting";	
		}	
	}	
	
	
	//------------------------------ 회원정보 수정 -------------------------//
	@RequestMapping("/updateProfile.do")
	public String updateProfile(MultipartFile file, HttpSession session, Member member) {	
		
		System.out.println("updateProfile.do:" + file);
		System.out.println("updateProfile.do(수정):" + member.getProfilePath());
		System.out.println("updateProfile.do:" + member.getNickname());

		//-------- (변경된 이미지가 존재하다면) img upload --------//
		if(!file.isEmpty()) {			
			try {
				member = uploadFile.uploadProfile(file, member);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		//------------------ 변경된 회원정보 DB에 넣기 -----------------//		
		member.setIdx((int)session.getAttribute("memberIdx")); //사용자 입력정보에 idx 추가하기			
		int result = memberService.updateProfile(member);

			if (result > 0) {
				sessionManage.setSessionMsg("성공적으로 수정되었습니다.", "success", session);
			} else {
				sessionManage.setSessionMsg("수정에 실패하였습니다", "error", session);
			}
			return "redirect:/";
	}

	
	
	//------------------------------문자인증회원 로그인------------------------//
	@RequestMapping("/phoneLogin.do")
	public String phoneLogin(HttpServletRequest request, HttpSession session, Member member) {	
		Member memberResult = memberService.phoneLogin(member);
		if (!Objects.isNull(memberResult) && bCryptPasswordEncoder.matches(member.getPwd(), memberResult.getPwd())) {
		
			//String previousUrl = request.getHeader("referer");
			//session.setAttribute("previousUrl", previousUrl);			
			session.setAttribute("memberIdx",memberResult.getIdx());		
			return "redirect:/";
							
		} else { //로그인 실패 
			sessionManage.setSessionMsg("로그인에 실패했습니다. 아이디와 패스워드를 확인해주세요.", "error", session);						
			return "redirect:/";
		}
	}
	
	//----------------------------------로그아웃-----------------------------//
	@RequestMapping("/logout.do")// 로그아웃
	public String logout(HttpSession session) {
		
		session.invalidate();		
		return "redirect:/";
	}

	
	//----------------------------------회원탈퇴-----------------------------//
	@RequestMapping("/withdraw.do")
	public String withdraw(HttpSession session) {			
		memberService.withdraw((int) session.getAttribute("memberIdx"));
		sessionManage.setSessionMsg("휴면개정으로 상태 변경되었습니다. 30일 이후 자동으로 회원탈퇴됩니다.", "success", session);	
		session.invalidate();
		return "redirect:/";
	}
	
	
	//--------------------------휴대전화 중복체크 (ajax)---------------------//
	@RequestMapping("/phoneCheck.do")
	@ResponseBody 
	public String phoneCheck (@RequestParam("phoneNumber") String phoneNumber) {
		 int isDuplicatePhoneNumber = memberService.phoneCheck(phoneNumber);
		 if (isDuplicatePhoneNumber > 0) {
	            return "success"; // 전화번호 중복 => 기존 가입자 
	     } else {
	            return "failed"; //  전화번호 중복 없음 => 신규 회원 (휴대폰 인증 필요)
	     }
	}
	

	
	//------------------------- 휴대폰본인인증 문자발송 (ajax)-------------------//
	@RequestMapping("/sendVerificationCode.do")
	@ResponseBody 
	public String sendVerificationCode (@RequestParam("phoneNumber") String phoneNumber) {	

		String result = messageController.sendOne(phoneNumber);
		//String result = "success";
System.out.println("memberController result : " + result);
		 if (result.equals("success") ) {			 	
	          return "success"; // 발송 성공
	     } else {	    	
	          return "failed"; // 발송 실패
	     }
	}
	
	
	//------------------------- 휴대폰본인인증 신규가입-------------------//
	@RequestMapping("/phoneJoin.do") // 휴대폰인증 BCD회원가입
	public String phoneJoin(HttpServletRequest request, RedirectAttributes redirectAttributes, HttpSession session, Member member, Model model) {
		
		//------------신규회원 입력정보---------------//
		String nickname = member.getNickname();
		String id = member.getId();
		String password = member.getPwd();
		String phone = member.getPhone();		
			
		//--------------유효성 검사-----------------//
		String nicknameRegex = "^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$"; 
		String idRegex = "^(?=.*[a-zA-Z0-9])[a-zA-Z0-9]{2,16}$"; 
		String passwordRegex = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$"; 

		//---------- 2차 검증 (닉네임/phone/id)--------//
		String nicknameOverlapCheck = nicknameCheck(member);
		int isExistPhone = memberService.phoneCheck(phone); 
		int isExistId = memberService.idCheck(id);
logger.info("");
System.out.println(isExistId);

		//--------------2차 검증 pass-------------//
		if(password.matches(passwordRegex) && nicknameOverlapCheck.equals("success") && id.matches(idRegex) && nickname.matches(nicknameRegex) && isExistId <=0 && isExistPhone <= 0) {
				 
			member.setPwd(bCryptPasswordEncoder.encode(member.getPwd()));//패스워드 암호화
		
			//------회원가입 진행------//
			int result = memberService.phoneJoin(member);
				if (result > 0) {			
					
					session.setAttribute("memberIdx",  member.getIdx());//회원가입 후 바로 회원번호 가져오기
					session.setAttribute("welcomeModal", "welcomeModal");
								
//					String previousUrl = request.getHeader("referer");// 이전페이지로 이동
//					session.setAttribute("previousUrl", previousUrl);
//					redirectAttributes.addFlashAttribute("welcomeModal", "welcomeModal");
					//model.addAttribute("welcomeModal", "welcomeModal");
					return "redirect:/board/list.do";	
			
				} else {	
					sessionManage.setSessionMsg("회원가입 중 오류가 발생했습니다. 잠시 후 다시 진행해주세요.", "error", session);
					return "redirect:/member/home.do";
				}
		} 
		//--------------2차 검증 failed-------------//	
		else {
			sessionManage.setSessionMsg("회원가입에 실패 했습니다. 가입정보를 다시 확인해주세요.", "error", session);
			return "redirect:/member/home.do";
		}	
	}
	
		
	
	//---------- 카카오,네이버로그인회원 BCD회원가입 (닉네임 설정 후 가입완료)-------------//
	@RequestMapping("/snsJoin.do")
	public String snsJoin(HttpServletRequest request, HttpSession session, Member member, Model model) {		
		//-------------2차 검증 (닉네임)---------------//
		int nicknameOverlapCheck = memberService.nicknameCheck(member.getNickname());
		
			//--------------2차 검증 pass---------------//
			if (nicknameOverlapCheck == 0) {		
				memberService.memberJoin(member); // BCD가입완료!				
				session.setAttribute("memberIdx", member.getIdx()); // 멤버 idx 세션에 심기!			
				session.setAttribute("welcomeModal", "welcomeModal"); //환영 메세지 모달용 키워드
			
				return "redirect:/board/list.do";	
			} 
			//--------------2차 검증 fail--------------//
			else {			
				return "common/error";	
			}

	}


	//------------ 네이버로그인 access_token 발행 + 프로필 정보 가져오기--------------//
	@RequestMapping("/loginResult")
	public String naversuccess(HttpServletRequest request, RedirectAttributes redirectAttributes, Model model, HttpSession session) throws Exception {

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

		// 가입여부 확인 (이메일로)
		int result = memberService.checkEmail(member);
		
		if (result <= 0) {
			// 사용자 정보 보내줘서 나머지 회원가입 마무리 시키기
			//model.addAttribute("member", member);
			session.setAttribute("member", member);
			// 사용자 이전 URL 가져오기
//			String currentUrl = (String) session.getAttribute("currentUrl");
//			String withoutJsp = currentUrl.replace(".jsp", "");
//			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제		
//		
			//if(previousUrl != null && previousUrl.equals("home")) {
				//session.setAttribute("previousUrl", previousUrl);
			session.setAttribute("snsLogin", "snsLogin");
				//redirectAttributes.addFlashAttribute("snsLogin", "snsLogin");
				//model.addAttribute("snsLogin", "snsLogin");// 소셜로그인(회원가입) 마무리 위한 닉네임 모달 띄우기용
				return "redirect:/board/list.do";				
				//return "redirect:/board/list.do";	
			//}
			
		} else { // 이미 회원인 경우	
			// 멤버 idx 가져오기
			//int m_idx = memberService.checkIdx(member);
			
			session.setAttribute("memberIdx", memberService.checkIdx(member));// 멤버 idx 가져오기
		
			// 사용자 이전 URL 가져오기
//			String currentUrl = (String) session.getAttribute("currentUrl");
//			String withoutJsp = currentUrl.replace(".jsp", "");
//			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제		
//		
//			if(previousUrl != null && previousUrl.equals("home")) {
//				session.setAttribute("previousUrl", previousUrl);
				return "redirect:/board/list.do"; 
			//}
	
	
		}

	}



	//------------ 카카오로그인 access_token 발행 + 프로필 정보 가져오기--------------//
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
	
		int result = memberService.checkEmail(member);
	

		if (result <= 0) {
			// 사용자 정보 보내주숴 나머지 회원가입 마무리 시키기
			//model.addAttribute("member", member);
			session.setAttribute("member", member);
			// 사용자 이전 URL 가져오기
//			String currentUrl = (String) session.getAttribute("currentUrl");
//			String withoutJsp = currentUrl.replace(".jsp", "");
//			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제
//			session.setAttribute("previousUrl", previousUrl);

			// 소셜로그인(회원가입) 마무리 위한 닉네임 모달 띄우기용
			//model.addAttribute("snsLogin", "snsLogin");
			session.setAttribute("snsLogin", "snsLogin"); // 소셜로그인(회원가입) 마무리 위한 닉네임 모달 띄우기용
			return "redirect:/board/list.do"; // BCD 닉네임 정하는 모달로 이동
			
		} else { // 이미 회원인 경우
					// 이전페이지로 이동		
			// 사용자 이전 URL 가져오기
//			String currentUrl = (String) session.getAttribute("currentUrl");
//			String withoutJsp = currentUrl.replace(".jsp", "");
//			String previousUrl = withoutJsp.substring(36); // 마지막으로부터 두 번째 슬래시까지 남기고 삭제		
//		
			// 멤버 idx 가져오기
			//int m_idx = memberService.checkIdx(member);
			session.setAttribute("memberIdx", memberService.checkIdx(member));// 멤버 idx 가져오기
			
//			if(previousUrl != null && previousUrl.equals("home")) {
//				session.setAttribute("previousUrl", previousUrl);
				return "redirect:/board/list.do";
			//}
			
			//return previousUrl;
		}
	}

	
	//--------------- 소셜로그인 사용자 정보 가져오기 from 네이버&카카오---------------//
	//1.네이버
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
	
	//2.카카오
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
