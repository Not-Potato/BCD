package kr.co.bcd.user.loginApi;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.user.loginApi.SNSLogin;
import kr.co.bcd.user.loginApi.SnsValue;
import kr.co.bcd.user.loginApi.UserService;


@Controller
public class UserController {
// 사용자에게 쇼설로그인 할수있는 주소를 보내주는 역할
//
//	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
//	
//	@Inject
//	private UserService service; 
//	
//	@Inject 
//	private SnsValue naverSns;// servlet-context bean를 가져오는것으로 이름을 반드시 일치시켜야함!
//
//	@Inject 
//	private SnsValue kakaoSns;
//
//	
//	@RequestMapping(value = "/user/model/{snsService}/callback", 
//			method = { RequestMethod.GET, RequestMethod.POST})
//	public String snsLoginCallback(@PathVariable String snsService,
//			Model model, @RequestParam String code, HttpSession session) throws Exception {
//		
//		logger.info("snsLoginCallback: service={}", snsService);
//		SnsValue sns = null;
//		if ("naver".equalsIgnoreCase(snsService))
//			sns = naverSns;
//		else
//			sns = kakaoSns;
//		
//		// 1. code를 이용해서 access_token 받기
//		// 2. access_token을 이용해서 사용자 profile 정보 가져오기
//		SNSLogin snsLogin = new SNSLogin(sns);
//	
//		
////		Member member = snsLogin.getUserProfile(code); // 1,2번 동시
////		System.out.println("Profile>>" + snsUser);
////		
////		// 3. DB 해당 유저가 존재하는 체크 (googleid, naverid 컬럼 추가)
////		User user = service.getBySns(snsUser);
////		if (user == null) {
////		model.addAttribute("result", "존재하지 않는 사용자입니다. 가입해 주세요.");
//			
//		//미존재시 가입페이지로!!
//			
//	//	} else {
//		//	model.addAttribute("result", member.getNickname() + "님 반갑습니다.");
//			
//		// 4. 존재시 강제로그인
//		//	session.setAttribute(SessionNames.LOGIN, user);
//	//	}
//		
//		
//		return "loginResult";
//	}
//	

}


