package kr.co.bcd.user.loginApi;
import com.github.scribejava.core.builder.api.DefaultApi20;

public class NaverAPI20 extends DefaultApi20 implements SnsUrls{
	private static NaverAPI20 _instance;
	private NaverAPI20() {	
	}
	
	private static class InstanceHolder {
		
	}
	
	public static NaverAPI20 getInstance() {
		if(_instance == null) {
			_instance = new NaverAPI20();
		} 
		return _instance;
	}
	
	@Override
	public String getAccessTokenEndpoint() {
		return NAVER_ACCESS_TOKEN;
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return NAVER_AUTH;
	}

}
