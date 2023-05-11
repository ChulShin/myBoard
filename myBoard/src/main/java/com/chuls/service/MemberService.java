package com.chuls.service;

import com.chuls.domain.MemberVO;

public interface MemberService {
	
	// 회원가입
	public void register(MemberVO vo) throws Exception;
}
