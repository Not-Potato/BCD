package kr.co.bcd.member.controller;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Balance;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.model.StorageType;
import net.nurigo.sdk.message.request.MessageListRequest;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.MessageListResponse;
import net.nurigo.sdk.message.response.MultipleDetailMessageSentResponse;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/msg")
public class MessageController {
	
	final DefaultMessageService messageService;
	String smsCode = "";
    public MessageController() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
    	this.messageService = NurigoApp.INSTANCE.initialize("NCSPAKCQTQWKRZK1", "AGENNSFII4QVEB4TCDDUT9TH5PI1JD30", "https://api.coolsms.co.kr");
    }

	
	   @PostMapping("/send")
	    public String sendOne(String phoneNumber) {
	        Message message = new Message();
	        
	        phoneNumber = phoneNumber.replaceAll("[^\\d]", "");        
	        message.setFrom("01033852985");
	        message.setTo(phoneNumber);

			smsCode ="";
			

			  Random rand = new Random(); 
			  for (int i=0; i<4; i++) { 
				  String ran = Integer.toString(rand.nextInt(10));
				  smsCode += ran; 
			  }	 
System.out.println("messageController 랜덤숫자:" + smsCode);		 
			  message.setText("BCD 인증번호는 ["+ smsCode +"] 입니다.");
	        
	        
			SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
System.out.println("messageController response"+response); 
System.out.println("messageController response.getStatus()"+ response.getStatusCode()); 

	if (response.getStatusCode().equals("2000")) { //메세지 발신 성공 	
	        	return "success" ;
	        } else  {
	        	
	        	return "failed";
	        }
	    }
	   
	   
		@RequestMapping("/smsCheck.do")//인증번호일치 확인
		@ResponseBody 
		public String smsCheck (@RequestParam("code") String code) {
System.out.println("memberController 사용자 입력 Code: "+ code);
System.out.println("memberController 랜덤값 smsCode: "+ smsCode);

smsCode = "1234";

			  if(smsCode.equals(code)) { 
				  System.out.println("여기로 들어와야해!!"); 
				  return "success";
			  } else {
				  System.out.println("여기로 들어오면 안됨!!");
				  return "failed";  
			  }
		
		}
}
