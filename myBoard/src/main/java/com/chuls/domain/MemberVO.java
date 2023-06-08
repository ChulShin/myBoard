package com.chuls.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
/*
	userId			varchar2(30)		not null,
	userPass		varchar2(100)		not null,
	userName		varchar2(30)		not null,
	regDate			date				default sysdate
	phoneNum		varchar2(25),
	address			varchar2(100),
	address_detail	varchar2(50),
	intro			varchar2(300),
	fileName		varchar2(100),
	photo,
*/
	@NotBlank
	private String userId;
	
	@NotBlank
	private String userPass;
	
	@NotBlank
	private String userName;
	
	private Date regDate;
	
	@NotBlank
	private String phoneNum;
	
	@NotBlank
	private String address;
	
	@NotBlank
	private String address_detail;
	
	@NotBlank
	private String intro;
	
	private String fileName;
	
	@NotNull
	private MultipartFile photo;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPass() {
		return userPass;
	}
	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPass=" + userPass + ", userName=" + userName + ", regDate="
				+ regDate + ", phoneNum=" + phoneNum + ", address=" + address + ", address_detail=" + address_detail
				+ ", intro=" + intro + ", fileName=" + fileName + ", photo=" + photo + "]";
	}
	
}