package kr.co.bcd.common.aws;

import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class S3UploadService {
	private final AmazonS3 amazonS3;
	
//	@Value("${aws.bucketName}")
	private String bucket;

	// upload
	public String upload(MultipartFile multipartFile, String fileName) throws IOException {
//		String originalFilename = multipartFile.getOriginalFilename();
		
		System.out.println(bucket);
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(multipartFile.getSize());
        metadata.setContentType(multipartFile.getContentType());

        amazonS3.putObject(bucket, fileName, multipartFile.getInputStream(), metadata);
        return amazonS3.getUrl(bucket, fileName).toString();
	}
}