package kr.co.bcd.common.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.board.post.model.service.PostServiceImpl;
import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.member.model.service.MemberServiceImpl;


@Controller
public class UploadFileController {
	public static final String UPLOAD_PATH = "C:\\prj\\springpj\\Project\\src\\main\\webapp\\resources\\upload\\";
	
	@Autowired
	private MemberServiceImpl memberService;

	@Autowired
	private PostServiceImpl postService;
	
	// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
	// 회원 프로필 이미지 파일 삭제 & 업로드
	//                              by. 형주
	// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
	
	// 파일 삭제
	public boolean deleteFile(Member member) {
		//member = memberService.detailMember(member.getIdx());
		
		if (!Objects.isNull(member)) {
			// 지워야 할 파일 = 경로 + 파일명
			File deleteFile = new File(member.getProfilePath() + member.getProfile());
			deleteFile.delete();
			return true;
		} else {
			return false;
		}
	}
	
	// 파일 업로드
	public Member uploadFile(MultipartFile upload, Member member) throws IllegalStateException, IOException {
		if (!upload.isEmpty()) {
			// 원본 파일명
			String originalName = upload.getOriginalFilename();
			
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
			// 경로 + 변경된 파일명
			String filePathName = UPLOAD_PATH + fileName;
			
			// 서버에 파일 저장
			Path filePath = Paths.get(filePathName);
			upload.transferTo(filePath);
			
			// 경로, 원본 파일명, 수정된 파일명 저장
			member.setProfilePath(UPLOAD_PATH);
			member.setProfileOrigin(originalName);
			member.setProfile(fileName);
		}
		return member;
	}
	
	
	// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
	// 투표 글 관련 이미지 파일 삭제 & 업로드
	//                               by. 자연
	// ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
	
	public boolean deleteFile(Post post) {
		post = postService.detailBoard(post.getIdx());
		
		if (!Objects.isNull(post)) {
			// 지워야 할 파일 = 경로 + 파일명
			File deleteFile = new File(post.getUploadPath() + post.getUpload1st());
			deleteFile.delete();
			
			deleteFile = new File(post.getUploadPath() + post.getUpload2nd());
			deleteFile.delete();
			return true;
		} else {
			return false;
		}
	}
	
	public Post uploadFile(MultipartFile upload1, MultipartFile upload2, Post post) throws IllegalStateException, IOException {
		// 첫 번째 파일
		if (!upload1.isEmpty()) {
			// 원본 파일명
			String originalName = upload1.getOriginalFilename();
			
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
			// 경로 + 변경된 파일명
			String filePathName = UPLOAD_PATH + fileName;
			
			// 서버에 파일 저장
			Path filePath = Paths.get(filePathName);
			upload1.transferTo(filePath);
			
			// 경로, 원본 파일명, 수정된 파일명 저장
			post.setUploadPath(UPLOAD_PATH);
			post.setUpload1stOrigin(originalName);
			post.setUpload1st(fileName);
		}
		
		// 두 번째 파일
		if (!upload2.isEmpty()) {
			// 원본 파일명
			String originalName = upload2.getOriginalFilename();
			
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
			// 경로 + 변경된 파일명
			String filePathName = UPLOAD_PATH + fileName;
			
			// 서버에 파일 저장
			Path filePath = Paths.get(filePathName);
			upload2.transferTo(filePath);
			
			// 경로, 원본 파일명, 수정된 파일명 저장
			post.setUploadPath(UPLOAD_PATH);
			post.setUpload2ndOrigin(originalName);
			post.setUpload2nd(fileName);
		}
		
		return post;
	}
}
