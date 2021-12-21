package com.service;

import com.common.AjaxResult;
import com.pojo.User;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @description: 用户service接口
 * @Author: shixinyu
 * @Date: 2021/10/9 10:07
 */
public interface UserService {
    /**
     * @Description: 查询用户
     * @Param: []
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/9
     */
    List<User> query(User user);
    /**
     * @Description: 删除用户
     * @Param: [id]
     * @return: int
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    int deleteUser(String id);
    /**
     * @Description:
     * @Param: [user]
     * @return: int
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    int addUser(User user);

    int updateUser(User user);
    /**
     * @Description: 批量删除
     * @Param: [ids]
     * @return: int
     * @Author: shixinyu
     * @Date: 2021/10/19
     */

    int deleteUserPl(String[] ids);

    AjaxResult login(User user, HttpServletRequest request);

    Object register(User user, HttpServletRequest request);
}
