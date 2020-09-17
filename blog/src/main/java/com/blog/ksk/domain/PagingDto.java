package com.blog.ksk.domain;

public class PagingDto {
	private int startRow = 1;// 보여지는 게시글 시작
	private int endRow = 10;// 보여지는 게시글 끝
	private String searchType;
	private String keyword;

	public PagingDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PagingDto(int startRow, int endRow, String searchType, String keyword) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.searchType = searchType;
		this.keyword = keyword;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "PagingDto [startRow=" + startRow + ", endRow=" + endRow + ", searchType=" + searchType + ", keyword="
				+ keyword + "]";
	}

}
