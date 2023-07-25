//package kr.co.bcd.user.loginApi;
//
//import java.io.IOException;
//
//import javax.inject.Inject;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.github.scribejava.core.model.OAuth2AccessToken;
//
//import kr.co.bcd.member.model.dto.Member;
//
//
//@Controller
//public class UserController {
//
//	@Inject
//	private UserService service; 
//	
//	@Inject 
//	private SnsValue naverSns;
//	
////	@Inject 
////	private SnsValue kakaoSns;
//	
//	
//    @RequestMapping(value = "/member/naverLogin", method = { RequestMethod.GET, RequestMethod.POST })
//    public void login(Model model)throws Exception {
//        
//    	SNSLogin snsLogin = new SNSLogin(naverSns);
//    	model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
//        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
//        
//        
//        //https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
//        //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
//        //System.out.println("네이버:" + naverAuthUrl);
//        
//      
//    }
//
//
//}