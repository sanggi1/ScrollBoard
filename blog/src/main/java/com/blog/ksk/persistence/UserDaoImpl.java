package com.blog.ksk.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.blog.ksk.domain.UserVo;

@Repository
public class UserDaoImpl implements UserDao {

	private static final String NAMESPACE = "mappers.user-mapper.";
	
	@Inject
	private SqlSession sqlSession;
	
	//회원가입
	@Override
	public void join(UserVo userVo) throws Exception {
		sqlSession.insert(NAMESPACE + "join", userVo);
	}

	//로그인
	@Override
	public UserVo login(String user_id, String user_pw) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("user_id", user_id);
		paramMap.put("user_pw", user_pw);
		return sqlSession.selectOne(NAMESPACE + "login", paramMap);
	}


	//아이디 중복 체크
	@Override
	public UserVo checkId(String user_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "checkId", user_id);
	}

	//이메일 체크
	@Override
	public UserVo checkEmail(UserVo userVo) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "checkEmail", userVo);
	}

	//비밀번호 변경
	@Override
	public void updatePw(UserVo userVo) throws Exception {
		System.out.println("ekdh" + userVo);
		sqlSession.update(NAMESPACE + "updatePw", userVo);
	}




}
