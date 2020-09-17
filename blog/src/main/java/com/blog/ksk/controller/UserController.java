package com.blog.ksk.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.blog.ksk.domain.UserVo;
import com.blog.ksk.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService userService;

	// 회원가입 폼
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void join() throws Exception {

	}

	// 회원가입 처리
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(UserVo userVo) throws Exception {
		userService.join(userVo);
		return "redirect:/user/login";
	}

	// 로그인 폼
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() throws Exception {

	}

	// 로그인 처리
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(String user_id, String user_pw, HttpSession session, RedirectAttributes rttr)throws Exception {
		boolean result = userService.login(user_id, user_pw);
		if (result == true) {
			// 해당 사용자가 있다면 아이디를 세션에 저장
			session.setAttribute("user_id", user_id);
			return "redirect:/board/list";
		}
		rttr.addFlashAttribute("msg", "fail");
		return "redirect:/user/login";
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		session.invalidate(); // 세션 무효화 -> 로그 아웃
		return "redirect:/user/login";
	}

	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value = "/checkId", method = RequestMethod.GET)
	public String checkId(String user_id) throws Exception {
		UserVo userVo = userService.checkId(user_id);
		if (userVo == null) {
			// 사용 가능
			return "possible";
		} else {
			// 사용 불가능
			return "impossible";
		}
	}

	// 이메일 인증 폼
	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public void findPw() throws Exception {

	}

	// 이메일 체크
	@ResponseBody
	@RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
	public String checkEmail(@RequestBody UserVo userVo) throws Exception {
		UserVo vo = userService.checkEmail(userVo);
		if (vo == null) {
			//일치하는 내용 없음
			return "impossible";
		} else {
			//일치하는 내용 있음
			return "possible";
		}
	}

	// 비밀번호 변경 폼
	@RequestMapping(value = "/updatePw", method = RequestMethod.GET)
	public void updatePw(String id, Model model) throws Exception {
		model.addAttribute("user_id", id);
	}

	// 비밀번호 변경 처리
	@RequestMapping(value = "/updatePw", method = RequestMethod.POST)
	public String updatePwPost(UserVo userVo) throws Exception {
		userService.updatePw(userVo);
		return "redirect:/user/login";
	}
}
