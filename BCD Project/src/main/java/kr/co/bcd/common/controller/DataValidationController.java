package kr.co.bcd.common.controller;

import org.springframework.stereotype.Controller;

@Controller
public class DataValidationController {
	// data와 제한 길이(byte)를 넣어서 true OR false로 반환하는 메소드
	public Boolean LanguageCheck(String data, int size) {
		int byteLength = 0;
		
		// .toCharArray()는 '안녕하세요' 문자열을 ['안', '녕', '하', '세', '요'] 문자 배열 형태로 만들어 주는 메소드
		for (char c : data.toCharArray()) {
			if (Character.toString(c).matches("[a-zA-Z]")) {
				// 영어일 때 += 1 byte
				byteLength += 1;
			} else if (Character.toString(c).matches("[ㄱ-ㅎㅏ-ㅣ가-힣]")) {				
				// 한글일 때 += 3 byte
				byteLength += 3;
			}
		}
		
		if (byteLength > size) {
			return false;
		} else {
			return true;
		}
	}
	
	// null check
	public Boolean nullCheck(String data) {
		if (data.isEmpty() || data == "<p>&nbsp;</p>") {
			return false;
		} else {
			return true;
		}
	}
}
