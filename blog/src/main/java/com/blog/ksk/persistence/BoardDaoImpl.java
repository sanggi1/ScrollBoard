package com.blog.ksk.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.blog.ksk.domain.AttachVo;
import com.blog.ksk.domain.BoardVo;
import com.blog.ksk.domain.PagingDto;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	private static final String NAMESPACE = "mappers.board-mapper.";
	
	@Inject
	private SqlSession sqlSession;
	// nextval
	@Override
	public int getNextVal() throws Exception {
		return sqlSession.selectOne(NAMESPACE + "getNextVal");
	}
	
	// 글쓰기
	@Override
	public void insertArticle(BoardVo boardVo) throws Exception {
		sqlSession.insert(NAMESPACE + "insertArticle", boardVo);
	}
	
	// 첨부파일 추가
	@Override
	public void insertAttach(String file_name, int bno) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("file_name", file_name);
		paramMap.put("bno", bno);
		sqlSession.insert(NAMESPACE + "insertAttach", paramMap);
	}

	//글 목록
	@Override
	public List<BoardVo> list(PagingDto pagingDto) throws Exception {
		List<BoardVo> list = sqlSession.selectList(NAMESPACE + "list", pagingDto);
		return list;
	}
	
	//첨부파일
	@Override
	public List<AttachVo> attachList() throws Exception {
		List<AttachVo> attachList = sqlSession.selectList(NAMESPACE + "attachList");
		return attachList;
	}

	//게시글 카운트
	@Override
	public int getCount() throws Exception {
		return  sqlSession.selectOne(NAMESPACE + "getCount");
	}

	//글 삭제
	@Override
	public void deleteArticle(int bno) throws Exception {
		sqlSession.selectOne(NAMESPACE + "deleteArticle", bno);
	}

	//첨부파일 삭제
	@Override
	public void deleteAttach(int bno) throws Exception {
		sqlSession.selectOne(NAMESPACE + "deleteAttach", bno);
	}

	//글 선택
	@Override
	public BoardVo selectBoard(int bno) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "selectBoard", bno);
	}

	//첨부파일 선택
	@Override
	public List<AttachVo> selectAttach(int bno) throws Exception {
		List<AttachVo> attachList = sqlSession.selectList(NAMESPACE+ "selectAttach", bno);
		return attachList;
	}

	//글 수정
	@Override
	public void updateArticle(BoardVo boardVo) throws Exception {
		sqlSession.selectOne(NAMESPACE + "updateArticle", boardVo);
		
	}

	//첨부파일 삭제(이름으로)
	@Override
	public void deleteImg(String file_name) throws Exception {
		sqlSession.selectOne(NAMESPACE + "deleteImg", file_name);
		
	}
	

}
