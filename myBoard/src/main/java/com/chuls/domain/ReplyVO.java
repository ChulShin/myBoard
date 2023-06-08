package com.chuls.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;

public class ReplyVO {
/*
	bno			number				not null,
	rno			number				not null,
	content		varchar2(2000)		not null,
	writer		varchar2(30)		not null,
	regDate		date				default sysdate,
*/
	private int bno;
	private int rno;
	
	@NotBlank
	private String content;
	
	@NotBlank
	private String writer;
	
	private Date regDate;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", content=" + content + ", writer=" + writer + ", regDate="
				+ regDate + "]";
	}
}
