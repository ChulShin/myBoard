package com.chuls.persistence;

import com.chuls.domain.MemberVO;

public interface MemberDAO {
	
	// 회원 가입
	public void register(MemberVO vo) throws Exception;
}
