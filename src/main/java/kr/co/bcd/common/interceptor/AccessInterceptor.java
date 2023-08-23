package kr.co.bcd.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AccessInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String referer = request.getHeader("referer");
		String requestURI = request.getRequestURI();
		String serverAddress = request.getRequestURL().toString();
		String localServerAddress = serverAddress.replace(requestURI, "");

		if ( (requestURI.equals("/board/detail.do")) && (referer == null || !referer.startsWith(localServerAddress)) ) {
			response.sendRedirect("/error");
			return false;
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable Exception ex) throws Exception {
	}
}