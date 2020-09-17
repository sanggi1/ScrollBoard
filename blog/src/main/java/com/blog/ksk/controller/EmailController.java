package com.blog.ksk.controller;

import java.util.UUID;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.ksk.domain.EmailDto;


@Controller
@RequestMapping(value ="email")
public class EmailController {

	@Inject
	private JavaMailSender javaMailSender;
	
	//비밀번호 찾기 처리
	@ResponseBody
	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public String findPwPost(@RequestBody String user_email)throws Exception{
		//임의의 문자열 생성하고 메일 전송
		UUID uuid = UUID.randomUUID();
		String code = uuid.toString().substring(0,6);
		
		String contents = "인증코드는 (" + code+ ")입니다.";
		EmailDto emailDto = new EmailDto();
		emailDto.setTo(user_email);
		emailDto.setContents(contents);
		
		// 메일정보 설정(from, to, subject, contents)
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
				helper.setFrom(emailDto.getFrom());
				helper.setTo(emailDto.getTo());
				helper.setSubject(emailDto.getSubject());
				helper.setText(emailDto.getContents());
			}
		};
		javaMailSender.send(preparator);
		return code;
	}
	

}
