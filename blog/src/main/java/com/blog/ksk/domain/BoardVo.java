package com.blog.ksk.domain;

import java.util.Arrays;

public class BoardVo {
	private int bno;
	private String title;
	private String content;
	private String regdate;// 비동기 방식으로 요청하기 위해 TimeStamp -> Stringfh로 변수 변경
	private String writer;

	private String[] files;

	public BoardVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BoardVo(int bno, String title, String content, String regdate, String writer, String[] files) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.writer = writer;
		this.files = files;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}

	@Override
	public String toString() {
		return "BoardVo [bno=" + bno + ", title=" + title + ", content=" + content + ", regdate=" + regdate
				+ ", writer=" + writer + ", files=" + Arrays.toString(files) + "]";
	}

}
