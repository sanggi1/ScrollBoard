package com.blog.ksk.domain;

public class AttachVo {
	private String file_name;
	private int bno;

	public AttachVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AttachVo(String file_name, int bno) {
		super();
		this.file_name = file_name;
		this.bno = bno;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	@Override
	public String toString() {
		return "AttachVo [file_name=" + file_name + ", bno=" + bno + "]";
	}

}
