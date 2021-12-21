package com.dao;

import com.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description:用户Dao
 * @Author: shixinyu
 * @Date: 2021/10/9 9:42
 */
public interface UserDao {
    /**
    * @Description: 查询用户
    * @Param: []
    * @return: java.util.List<com.pojo.User>
    * @Author: shixinyu
    * @Date: 2021/10/9
    */
    List<User> query(User user);
    /**
    * @Description: 删除
    * @Param: [id]
    * @return: int
    * @Author: shixinyu
    * @Date: 2021/10/11
    */

    int deleteUser(String id);

    int addUser(User user);

    int updateUser(User user);
    /**
     * @Description: 批量删除
     * @Param: [ids]
     * @return: int
     * @Author: shixinyu
     * @Date: 2021/10/19
     */

    int deleteUserPl(@Param("ids") String[] ids);


    List<User> selectList(User users);
}
