package com.blog.ksk.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.blog.ksk.domain.AttachVo;
import com.blog.ksk.domain.BoardVo;
import com.blog.ksk.domain.PagingDto;
import com.blog.ksk.persistence.BoardDao;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDao boardDao;

	// 글쓰기
	@Transactional
	@Override
	public void insertArticle(BoardVo boardVo) throws Exception {
		// bno값 얻기
		int bno = boardDao.getNextVal();
		boardVo.setBno(bno);
		boardDao.insertArticle(boardVo);

		// 첨부파일 있을때만 수행
		if (boardVo.getFiles() != null) {
			String[] files = boardVo.getFiles();
			for (String file_name : files) {
				boardDao.insertAttach(file_name, bno);
			}
		}
	}

	// 글목록
	@Override
	public List<BoardVo> list(PagingDto pagingDto) throws Exception {
		List<BoardVo> list = boardDao.list(pagingDto);
		return list;
	}

	// 첨부파일
	@Override
	public List<AttachVo> attachList() throws Exception {
		List<AttachVo> attachList = boardDao.attachList();
		return attachList;
	}

	//게시글 카운트
	@Override
	public int getCount() throws Exception {
		return boardDao.getCount();
	}

	//글삭제
	@Override
	public void deleteArticle(int bno) throws Exception {
		boardDao.deleteArticle(bno);
	}

	//첨부파일 삭제
	@Override
	public void deleteAttach(int bno) throws Exception {
		boardDao.deleteAttach(bno);
	}

	//글 선택
	@Override
	public BoardVo selectBoard(int bno) throws Exception {
		return boardDao.selectBoard(bno);
	}

	//첨부파일 선택
	@Override
	public List<AttachVo> selectAttach(int bno) throws Exception {
		List<AttachVo> attachList = boardDao.selectAttach(bno);
		return attachList;
	}

	//글 수정
	@Override
	public void updateArticle(BoardVo boardVo) throws Exception {
		boardDao.updateArticle(boardVo);
		
		// 첨부파일 있을때만 수행
		if (boardVo.getFiles() != null) {
			String[] files = boardVo.getFiles();
			for (String file_name : files) {
				boardDao.insertAttach(file_name, boardVo.getBno());
			}
		}
	}

	//첨부파일 삭제(이름으로)
	@Override
	public void deleteImg(String file_name) throws Exception {
		boardDao.deleteImg(file_name);
		
	}

}
