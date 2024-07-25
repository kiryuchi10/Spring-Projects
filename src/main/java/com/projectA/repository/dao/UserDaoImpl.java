package com.projectA.repository.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.projectA.repository.vo.UserVo;

import jakarta.validation.Valid;

@Repository("userDao")
public class UserDaoImpl implements UserDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(UserVo vo) {
		// Implement the insert method
		return sqlSession.insert("users.insertUser", vo); // Adjust to actual MyBatis insert statement ID
	}

	@Override
	public UserVo selectUser(String name) {
		return sqlSession.selectOne("users.selectUserByName", name);
	}

	@Override
	public UserVo findByUsernameForLogin(@Param("username") String username) {
		return sqlSession.selectOne("users.selectUserByNameForLogin", username);
	}

	@Override
	public UserVo selectUser(String name, String password) {
		Map<String, String> userMap = new HashMap<>();
		userMap.put("name", name);
		userMap.put("password", password);
		return sqlSession.selectOne("users.selectUserByNameAndPassword", userMap);
	}

	@Override
	public List<UserVo> getList() {
		return sqlSession.selectList("users.selectUserList");
	}

	@Override
	public long getCount() {
		return sqlSession.selectOne("users.countUserCode0");
	}

	@Override
	public List<UserVo> getAllBranches() {
		return sqlSession.selectList("users.selectBranchList");
	}

	@Override
	public List<UserVo> selectBookOrdersByMonthYear(Integer month, Integer year) {
		Map<String, Integer> params = new HashMap<>();
		params.put("month", month);
		params.put("year", year);
		return sqlSession.selectList("users.selectBookOrdersByMonthYear", params);
	}

	@Override
	public int delete(long no) {
		return sqlSession.delete("users.deleteUser", no); // Adjust to actual MyBatis delete statement ID
	}

	@Override
	public List<UserVo> selectAllBranches() {
		return sqlSession.selectList("users.selectAllBranches"); // Ensure the ID matches your MyBatis XML
	}

	@Override
	public List<UserVo> selectAllUsers() {
		return sqlSession.selectList("users.selectAllUsers"); // Ensure the ID matches your MyBatis XML
	}

	@Override
	public UserVo selectUserByNameForLogin(String username) {
		return sqlSession.selectOne("users.selectUserByNameForLogin", username); // Adjust based on the actual
																					// requirement
	}

	@Override
	public void save(@Valid UserVo userVo) {
		sqlSession.insert("users.saveUser", userVo); // Adjust to actual MyBatis insert or update statement ID
	}

	@Override
	public List<UserVo> selectBookOrdersByMonthYear() {
		// This method should either accept parameters or be removed if not needed
		return sqlSession.selectList("users.selectBookOrdersByMonthYear");
	}

	//동현 
	@Override
	public List<UserVo> selectAllBookOrders() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("users.selectAllBookOrders");
	}

	@Override
	public List<UserVo> getBranchListSummary() {
		return sqlSession.selectList("users.getBranchListSummary");
	}
}
