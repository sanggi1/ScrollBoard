package com.blog.ksk.service;

import com.blog.ksk.domain.UserVo;

public interface UserService {

	//회원가입
	public void join(UserVo userVo) throws Exception;
	
	//로그인
	public boolean login(String user_id, String user_pw) throws Exception;
	
	// 아이디 중복체크
	public UserVo checkId(String user_id) throws Exception;
	
	//이메일 체크
	public UserVo checkEmail(UserVo userVo) throws Exception;
	
	//비밀번호 변경
	public void updatePw(UserVo userVo) throws Exception;
}
