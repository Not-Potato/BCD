package kr.co.bcd.common.aws;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

@Configuration
@PropertySource("classpath:application.properties")
public class S3UploadConfig {
	@Value("${aws.accessKey}")
	private String accessKey;

	@Value("${aws.secretKey}")
	private String secretKey;
	
	@Value("${aws.region}")
	private String region;
	
	@Bean
	public AmazonS3 amazonS3() {
		System.out.println(region);
		AWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
		
		return AmazonS3ClientBuilder.standard()
									.withRegion(region)
									.withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
									.build();
	}
	
}
