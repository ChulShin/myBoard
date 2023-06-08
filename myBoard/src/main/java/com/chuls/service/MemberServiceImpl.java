package com.chuls.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.chuls.domain.MemberVO;
import com.chuls.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{

	@Inject
	private MemberDAO dao;
	
	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		dao.register(vo);
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return dao.login(vo);
	}

	// 회원정보 수정
	@Override
	public void modify(MemberVO vo) throws Exception {
		dao.modify(vo);
	}

	// 회원 탈퇴
	@Override
	public void withdrawal(MemberVO vo) throws Exception {
		dao.withdrawal(vo);
	}

	// 아이디 확인
	@Override
	public MemberVO idCheck(String userId) throws Exception {
		return dao.idCheck(userId);
	}

	// 닉네임 확인
	@Override
	public MemberVO userNameCheck(String userName) throws Exception {
		return dao.userNameCheck(userName);
	}

	// 비밀번호 확인
	@Override
	public MemberVO userPassCheck(String userId) throws Exception {
		return dao.userPassCheck(userId);
	}
	
}
