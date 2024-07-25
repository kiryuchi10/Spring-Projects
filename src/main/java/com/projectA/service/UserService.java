package com.projectA.service;

import java.util.List;

import com.projectA.repository.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

public interface UserService {
	//	가입
	public boolean join(UserVo vo);
	//	아이디로 유저 정보 검색
	public UserVo getUser(String name);
	
	public UserVo getUserByNameForLogin(String username);
	
	//	로그인
	public UserVo getUser(String name, String password);
	//	유저 리스트
	public List<UserVo> getList();
	//	승인 대기 유저 수
	public long userCount();
	//	계정 삭제
	public boolean delete(long no);
	//	계정 승인

	//	인증 체크 메서드 
	public boolean isAuthenticated(HttpServletRequest request);
	public void saveUserWithTokenizedPassword(@Valid UserVo userVo, String tokenizedPassword);
	List<UserVo> getAllBranches();
	List<UserVo> getBranchListSummary();
	List<UserVo> selectAllBookOrders(); // Method to fetch all book orders
	
	
}
