package kr.co.bcd.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller
public class SessionManageController {
	public void setSessionMsg(String msg, 
							  String status, 
							  HttpSession session) {
		session.setAttribute("msg", msg);
		session.setAttribute("status", status);
	}
	
	public void getSessionMsg(HttpSession session, Model model) {
		model.addAttribute("msg", (String)session.getAttribute("msg"));
		model.addAttribute("status", (String)session.getAttribute("status"));
		
		session.removeAttribute("msg");
		session.removeAttribute("status");
	}
}
