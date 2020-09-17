package com.blog.ksk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/util")
public class UtilController {
	
	
	//주소찾기
	@RequestMapping(value = "/address", method = RequestMethod.GET)
	public void address() throws Exception {
	}
	
	//일기예보
	@RequestMapping(value = "/weather", method = RequestMethod.GET)
	public void weather() throws Exception {
	}
}
