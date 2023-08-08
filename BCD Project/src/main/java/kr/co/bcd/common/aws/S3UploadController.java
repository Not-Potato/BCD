package kr.co.bcd.common.aws;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.member.model.dto.Member;

@Controller
public class S3UploadController {
	@Autowired
	private S3UploadService uploadService;
	
	// 게시글 파일 업로드
	public Post uploadPostFile(MultipartFile file1, MultipartFile file2, Post post) throws IllegalStateException, IOException {
		if(!file1.isEmpty()) {
			// 원본 파일명
			String originalName = file1.getOriginalFilename();
			
			// 확장자 구하기
			String extension = originalName.substring(originalName.lastIndexOf("."));
			
			// 현재 년-월-일-시-분-초
			LocalDateTime now = LocalDateTime.now();
			
			// 년월일시분초 형식으로 데이터 가공
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
			String output = "bcd_" + now.format(formatter);
			
			// 랜덤 문자열 생성
			int length = 8;
			String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&"; // 사용할 문자들
			
			Random random = new Random();
			
			String randomString = random.ints(length, 0, characters.length())
					.mapToObj(characters::charAt)
					.map(Object::toString)
					.collect(Collectors.joining());
			
			// DB에 저장할 파일명
			String fileName = (output + "_" + randomString + extension);
			
			// TODO: 서버에 파일 저장 + 파일 주소 저장
			String url = uploadService.upload(file1, fileName);
			System.out.println(url);

			post.setImg1URL(url);
		}

		if(!file2.isEmpty()) {
			// 원본 파일명
			String originalName = file2.getOriginalFilename();
			
			// 확장자 구하기
			String extension = originalName.substring(originalName.lastIndexOf("."));
			
			// 현재 년-월-일-시-분-초
			LocalDateTime now = LocalDateTime.now();
			
			// 년월일시분초 형식으로 데이터 가공
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
			String output = "bcd_post_" + now.format(formatter);
			
			// 랜덤 문자열 생성
			int length = 8;
			String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&"; // 사용할 문자들
			
			Random random = new Random();
			
			String randomString = random.ints(length, 0, characters.length())
					.mapToObj(characters::charAt)
					.map(Object::toString)
					.collect(Collectors.joining());
			
			// DB에 저장할 파일명
			String fileName = (output + "_" + randomString + extension);
			
			// TODO: 서버에 파일 저장 + 파일 주소 저장
			String url = uploadService.upload(file2, fileName);
			System.out.println(url);
			
			post.setImg2URL(url);
		}
		
		return post;
	}

	// 프로필 사진 업로드
	public Member uploadProfile(MultipartFile file, Member member) throws IllegalStateException, IOException {
		if(!file.isEmpty()) {
			// 원본 파일명
			String originalName = file.getOriginalFilename();
			
			// 확장자 구하기
			String extension = originalName.substring(originalName.lastIndexOf("."));
			
			// 현재 년-월-일-시-분-초
			LocalDateTime now = LocalDateTime.now();
			
			// 년월일시분초 형식으로 데이터 가공
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
			String output = "bcd_profile_" + now.format(formatter);
			
			// 랜덤 문자열 생성
			int length = 8;
			String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&"; // 사용할 문자들
			
			Random random = new Random();
			
			String randomString = random.ints(length, 0, characters.length())
					.mapToObj(characters::charAt)
					.map(Object::toString)
					.collect(Collectors.joining());
			
			// DB에 저장할 파일명
			String fileName = (output + "_" + randomString + extension);
			
			// 서버에 파일 저장 + 저장된 url 리턴
			String url = uploadService.upload(file, fileName);
			
			// member 객체에 url 담아서
			member.setProfilePath(url);
		}
		// member 리턴
		return member;
	}
}
