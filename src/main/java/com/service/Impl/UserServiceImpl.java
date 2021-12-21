package com.service.Impl;

import com.common.AjaxResult;
import com.common.MD5Util;
import com.dao.UserDao;
import com.pojo.User;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description: 用户service实现类
 * @Author: shixinyu
 * @Date: 2021/10/9 10:08
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;



    /**
     * @Description: 查询用户
     * @Param: []
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/9
     */
    @Override
    public List<User> query(User user) {
        return userDao.query(user);
    }
    /**
     * @Description:
     * @Param: [id]
     * @return: int
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @Override
    public int deleteUser(String id) {
        return userDao.deleteUser(id);
    }
    /**
     * @Description:
     * @Param: [user]
     * @return: int
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @Override
    public int addUser(User user) {
        return userDao.addUser(user);
    }

    @Override
    public int updateUser(User user) {
        return userDao.updateUser(user);
    }

    @Override
    public int deleteUserPl(String[] ids) {
        return userDao.deleteUserPl(ids);
    }

    /**
    *@Description:登陆功能
    *@param:[user, request]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/11/19
    */
    @Override
    public AjaxResult login(User user, HttpServletRequest request) {
        //
        User userForName = new User();
        userForName.setUserName(user.getUserName());
        List<User> list_name = userDao.selectList(userForName);
        if (list_name.size() == 0){
            //当前用户没有查询到数据,说明用户名不存在
            return AjaxResult.error("户名不存在");
        }
        //2.密码正确性校验
       User nowUser=list_name.get(0);
        //校验密码
        String pwd_input= MD5Util.getMD5Str(user.getPassword());
        if (!pwd_input.equals(nowUser.getPassword())){
            //出参数的密码进行加密后，与数据库的密码进行比较，如果相同，正确，如果不同，密码错误，
            return  AjaxResult.error("密码错误");
        }



        //3.两次校验都成功后返回用户信息

        Map<String,Object> map = new HashMap<>();
        map.put("userInfo",nowUser);
        //map.put("token",token);
        //登录成功用户信息存放到session
        request.setAttribute("loginUser",nowUser);
        return AjaxResult.success(map);
    }
    /**
    *@Description:注册功能
    *@param:[user, request]
    *@return:java.lang.Object
    *@Author:shixinyu
    *@Date:2021/11/19
    */
    @Override
    public Object register(User user, HttpServletRequest request) {
        User users = new User();
        users.setUserName(user.getUserName());
        List<User> userList = userDao.selectList(users);
        if (userList.size() > 0) {
            //如果查询到了数据，说明当前用户名已经存在
            return AjaxResult.error("用户名已存在");
        }
        User usersPhone = new User();
        usersPhone.setMobile(user.getMobile());
        List<User> userListMobile = userDao.selectList(users);
        if (userList.size() > 0) {
            //如果查询到了数据，说明当前电话号已经存在
            return AjaxResult.error("电话号码已经被注册");
        }
        user.setUserName(user.getUserName());
        user.setSex(user.getSex());
        user.setPassword(MD5Util.getMD5Str(user.getPassword()));
        user.setIsDelete("0");
        user.setMobile(user.getMobile());
        userDao.addUser(user);
        return AjaxResult.success();
    }
}


