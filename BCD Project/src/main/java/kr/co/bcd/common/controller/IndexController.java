package kr.co.bcd.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class IndexController {
	private final SessionManageController sessionManage;
	
	public IndexController(SessionManageController sessionManage) {
        this.sessionManage = sessionManage;
    }
	
	@RequestMapping("/")
	public String index() {
		return "forward:/board/list.do";
	}
	
	@GetMapping("/redirect.do")
	public String redirectIndex(RedirectAttributes redirectAttributes, HttpSession session) {
		sessionManage.setSessionMsg("로그인 후 이용 가능합니다!", "error", session);
		return "redirect:/";
	}
	
	@GetMapping("/error")
	public String errorPage() {
		return "/common/errorPage";
	}
}
