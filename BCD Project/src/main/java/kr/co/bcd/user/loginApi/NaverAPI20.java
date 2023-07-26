package kr.co.bcd.user.loginApi;
import com.github.scribejava.core.builder.api.DefaultApi20;

public class NaverAPI20 extends DefaultApi20 implements SnsUrls{
	//싱글톤: jvm에 오브젝트가 하나만 생기게 하는 것! 
	// 		외부에서 클래스 생성 금지 (생성자가 private) 
	//싱글톤 만드는 방법은 여러가지가 있음
	//방법.1 :instanace 생성 후 getInstance 매소드 호출
	//	private static NaverAPI20 _instance; 
	//	public static NaverAPI20 getInstance() {
	//		if(_instance == null) { 			: 인스턴스 null인 경우
	//			_instance = new NaverAPI20(); 	: 인스턴스 새로 생성 후 _instance에 넣어줌
	//		} else 								: 인스턴스 생성된 경우
	//			return _instance;				: "그"인스턴스 그대로 반환
	//	}
	
	//방법.2 : InstanceHolder 방법
	private NaverAPI20() {	
	}
	
	private static class InstanceHolder { //InstanceHolder를 부를 떄 NaverAPI20이 생성됨!
		private static final NaverAPI20 INSTANCE = new NaverAPI20();   
	}
	
	public static NaverAPI20 instance() { 
		return InstanceHolder.INSTANCE;  // InstanceHolder클래스의 INSTANCE는  final이라서 한번만 생성됨! 
	}
	
	//DefaultApi20(추상클래스): 필요한 것만 골라서 구현! ....vs 인터페이스: 는 모두 구현! 
	@Override
	public String getAccessTokenEndpoint() {
		return NAVER_ACCESS_TOKEN;
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return NAVER_AUTH;
	}

}
