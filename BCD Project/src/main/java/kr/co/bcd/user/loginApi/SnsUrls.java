package kr.co.bcd.user.loginApi;

public interface SnsUrls {
	// 네이버에서 제공하는 URL(변하지 않음)로 전역변수로 사용하기 위해 interface로 만듬!
	static final String NAVER_ACCESS_TOKEN = "https://nid.naver.com/oath2.0/token?grant_type=authorization_code"; // Access_token을 받아오는 URL
	static final String NAVER_AUTH = "https://nid.naver.com/oauth2.0/authorize"; // 
	
	
	static final String NAVER_PROFILE_URL = "https://openapi.naver.com/v1/nid/me";//Access_token을 가지고 정보를 가질로 갈 URL임! 
	
}
