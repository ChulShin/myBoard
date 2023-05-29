package com.chuls.service;

import com.chuls.domain.MemberVO;

public interface MemberService {
	
	// 회원가입
	public void register(MemberVO vo) throws Exception;
	
	// 로그인
	public MemberVO login(MemberVO vo) throws Exception;
	
	// 회원정보 수정
	public void modify(MemberVO vo) throws Exception;
	
	// 회원 탈퇴
	public void withdrawal(MemberVO vo) throws Exception;
	
	// 아이디 확인
	public MemberVO idCheck(String userId) throws Exception;
	
	// 닉네임 확인
	public MemberVO userNameCheck(String userName) throws Exception;
}
