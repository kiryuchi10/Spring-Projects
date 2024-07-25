package com.projectA.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.projectA.repository.dao.UserDao;
import com.projectA.repository.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public boolean join(UserVo vo) {
        int insertedCount = userDao.insert(vo);
        return insertedCount==1;
    }

    @Override
    public UserVo getUser(String name) {
        return userDao.selectUser(name);
    }

    @Override
    public UserVo getUser(String name, String password) {
        return userDao.selectUser(name, password);
    }

    @Override
    public boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            UserVo authUser = (UserVo) session.getAttribute("authUser");
            return authUser != null;
        }

        return false;
    }

    @Override
    public long userCount() {
        return userDao.getCount();
    }

    @Override
    public boolean delete(long no) {
        int deleteCount = userDao.delete(no);
        return deleteCount == 1;
    }

 

    @Override
    public UserVo getUserByNameForLogin(String username) {
        return userDao.selectUserByNameForLogin(username);
    }

    @Override
    public List<UserVo> getList() {
        return userDao.selectAllUsers();
    }

    @Override
    public void saveUserWithTokenizedPassword(@Valid UserVo userVo, String tokenizedPassword) {
        userVo.setPassword(tokenizedPassword);
        userDao.save(userVo);
    }

    @Override
    public List<UserVo> getAllBranches() {
        return userDao.selectAllBranches();
    }
    

    @Override
    public List<UserVo> getBranchListSummary() {
        return userDao.getBranchListSummary();
    }
    
    //동현 파트-> 추후에는 ordercheckdao로 
    @Override
    public List<UserVo> selectAllBookOrders() {
        return userDao.selectAllBookOrders(); // Fetch all book orders
    }


}
