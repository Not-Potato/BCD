package kr.co.bcd.user.loginApi;

import java.io.IOException;
import javax.servlet.http.HttpSession;
import org.springframework.util.StringUtils;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.builder.api.DefaultApi20;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import lombok.Data;

@Data
public class SnsValue implements SnsUrls {
	private String service;
    private String clientId;      
    private String clientSecret;                    
    private String redirectUrl;
    private DefaultApi20 api20Instance;
    
    //servlet-context naverSns는 4개의 constructor-arg갖는 bean이므로 그에 맞춰 생성자를 만들어줌
    public SnsValue(String service, String clientID, String clientSecret, String redirectUrl) {
    	this.service = service; 
    	this.clientId = clientID; 
    	this.clientSecret = clientSecret;
    	this.redirectUrl = redirectUrl;
    	
    	if ("naver".equalsIgnoreCase(service)) {
    		this.api20Instance = NaverAPI20.instance(); // 싱글톤
    	}else if ("kakao".equalsIgnoreCase(service)) {
    		//this.api20Instance = KakaoAPI20.instance();
    		
    	}
    			
    }
    
    /* 프로필 조회 API URL */
//    private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";/// Api 종류 기본 !!
    

}
