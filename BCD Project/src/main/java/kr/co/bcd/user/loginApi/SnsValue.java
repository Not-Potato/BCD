package kr.co.bcd.user.loginApi;


import java.io.IOException;
import java.util.UUID;

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
    
    public SnsValue(String service, String clientID, String clientSecret, String redirectUrl) {
    	this.service = service; 
    	this.clientId = clientID; 
    	this.clientSecret = clientSecret;
    	this.redirectUrl = redirectUrl;
    	
    	
    }
    
    /* 프로필 조회 API URL */
    private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";/// Api 종류 기본 !!
    

}
