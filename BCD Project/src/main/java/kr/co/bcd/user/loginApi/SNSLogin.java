package kr.co.bcd.user.loginApi;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.oauth.OAuth20Service;

public class SNSLogin {
	private OAuth20Service oauthService;
	
	// SnsValue를 받는 생성자
	public SNSLogin(SnsValue sns) {
		this.oauthService = new ServiceBuilder()
				.apiKey(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.scope("profile")
				.build(sns.getApi20Instance());
				
	}	

	public String getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl(); // scribejava를 쓰서 authservice를 활용하여 만듬. 서비스를 통해서 해야 네이버서버 다녀오는 프로세스를 생략가능하다!
	}
}
