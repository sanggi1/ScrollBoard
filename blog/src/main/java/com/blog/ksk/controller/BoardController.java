package com.blog.ksk.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.blog.ksk.domain.AttachVo;
import com.blog.ksk.domain.BoardVo;
import com.blog.ksk.domain.PagingDto;
import com.blog.ksk.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Inject
	private BoardService boardService;

	// 글 등록 폼
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGet() throws Exception {

	}

	// 글 등록 처리
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(BoardVo boardVo, RedirectAttributes rttr, HttpSession session) throws Exception {
		//세션에 저장된 user_id 값 가져와서 boardVo에 담는다
		String user_id = (String) session.getAttribute("user_id");
		boardVo.setWriter(user_id);
		
		boardService.insertArticle(boardVo);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/list";
	}

	// 글 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, PagingDto pagingDto) throws Exception {
		//게시글 리스트
		List<BoardVo> list = boardService.list(pagingDto);
		//첨부파일 리스트
		List<AttachVo> attachList = boardService.attachList();
		model.addAttribute("list", list);
		model.addAttribute("attachList", attachList);
		return "board/list";
	}

	// 글 더보기
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/moreList", method = RequestMethod.POST)
	public List<BoardVo> moreList(@RequestBody PagingDto pagingDto) throws Exception {
		List<BoardVo> list = boardService.list(pagingDto);
		List<AttachVo> attachList = boardService.attachList();
		int attachIndex = 0;
		String[] arrAttach = new String[attachList.size()];
		//boardVo의 files배열에 첨부파일 담기
		for (int i = 0; i <= list.size() - 1; i++) {
			for (int j = 0; j <= attachList.size() - 1; j++) {
				
				if (list.get(i).getBno() == attachList.get(j).getBno()) {
					arrAttach[attachIndex] = attachList.get(j).getFile_name();
					list.get(i).setFiles(arrAttach);
					attachIndex++;
					
				}
			}
		}
		return list;
	}

	// 글 삭제
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/deleteArticle/{bno}", method = RequestMethod.DELETE)
	public String deleteArticle(@PathVariable int bno) throws Exception {
		boardService.deleteAttach(bno);
		boardService.deleteArticle(bno);
		return "success";

	}

	// 글 수정 폼
	@RequestMapping(value = "/updateArticle", method = RequestMethod.GET)
	public void updateAtricle(int bno, Model model) throws Exception {
		BoardVo boardVo = boardService.selectBoard(bno);
		List<AttachVo> attachList = boardService.selectAttach(bno);
		
		model.addAttribute("boardVo", boardVo);
		model.addAttribute("attachList", attachList);
	}

	// 글 수정(사진 삭제)
	@ResponseBody
	@RequestMapping(value = "/deleteImg", method = RequestMethod.DELETE)
	public String deleteImg(@RequestBody String file_name) throws Exception {
		boardService.deleteImg(file_name);
		return "success";
	}

	// 글 수정 처리
	@RequestMapping(value = "/updateArticle", method = RequestMethod.POST)
	public String updateAtricle(BoardVo boardVo, RedirectAttributes rttr) throws Exception {
		boardService.updateArticle(boardVo);
		rttr.addFlashAttribute("msg", "update");
		return "redirect:/board/list";
	}
}
