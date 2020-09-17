package com.blog.ksk.service;

import java.util.List;

import com.blog.ksk.domain.AttachVo;
import com.blog.ksk.domain.BoardVo;
import com.blog.ksk.domain.PagingDto;

public interface BoardService {

	// 글쓰기
	public void insertArticle(BoardVo boardVo) throws Exception;

	// 글목록
	public List<BoardVo> list(PagingDto pagingDto) throws Exception;
	
	//첨부파일
	public List<AttachVo> attachList() throws Exception;

	//게시글 카운트
	public int getCount() throws Exception;
	
	//글 삭제
	public void deleteArticle(int bno) throws Exception;
	
	//첨부파일 삭제
	public void deleteAttach(int bno) throws Exception;
	
	//글 선택
	public BoardVo selectBoard(int bno) throws Exception;
	
	//첨부파일선택
	public List<AttachVo> selectAttach(int bno) throws Exception;
	
	//글수정
	public void updateArticle(BoardVo boardVo) throws Exception;
	
	//첨부파일 삭제(이름으로)
	public void deleteImg(String  file_name) throws Exception;
}
