package com.blog.ksk.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.blog.ksk.domain.UserVo;
import com.blog.ksk.persistence.UserDao;


@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDao userDao;
	
	//로그인
	@Override
	public void join(UserVo userVo) throws Exception{
		userDao.join(userVo);
	}

	//회원가입
	@Override
	public boolean login(String user_id, String user_pw) throws Exception {
		UserVo userVo = userDao.login(user_id, user_pw);
		if (userVo == null) {
			return false;
		}
		return true;
	}
	
	// 아이디 중복 체크
	@Override
	public UserVo checkId(String user_id) throws Exception {
		return userDao.checkId(user_id);
	}

	//이메일 체크
	@Override
	public UserVo checkEmail(UserVo userVo) throws Exception {
		return userDao.checkEmail(userVo);
	}

	//비밀번호 변경
	@Override
	public void updatePw(UserVo userVo) throws Exception {
		userDao.updatePw(userVo);
	}



}
