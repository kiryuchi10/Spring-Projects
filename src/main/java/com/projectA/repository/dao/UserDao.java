package com.projectA.repository.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.projectA.repository.vo.UserVo;

import jakarta.validation.Valid;

public interface UserDao {
    // Method to insert a new user
    int insert(UserVo vo);

    // Method to fetch a user by name
    UserVo selectUser(String name);

    // Method to find a user by username for login
    UserVo findByUsernameForLogin(@Param("username") String username);

    // Method to fetch a user by name and password
    UserVo selectUser(@Param("name") String name, @Param("password") String password);

    // Method to fetch all users
    List<UserVo> getList();

    // Method to get the count of users
    long getCount();

    // Method to delete a user by ID
    int delete(long no);

    // Method to fetch book orders by month and year
    List<UserVo> selectBookOrdersByMonthYear(@Param("month") Integer month, @Param("year") Integer year);

    // Method to get branch list summary
    List<UserVo> getBranchListSummary();

    // Method to fetch all book orders
    List<UserVo> selectAllBookOrders();

    // Method to select all branches
    List<UserVo> selectAllBranches();

    // Method to select all users
    List<UserVo> selectAllUsers();

    // Method to save or update a user
    void save(@Valid UserVo userVo);

	List<UserVo> getAllBranches();

	List<UserVo> selectBookOrdersByMonthYear();

	UserVo selectUserByNameForLogin(String username);
}
