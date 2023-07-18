package kr.co.bcd.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;

@Controller
public class SessionManageController {
	public void setSessionMsg(String msg, 
							  String status, 
							  HttpSession session) {
		session.setAttribute("msg", msg);
		session.setAttribute("status", status);
	}
}
