package com.controller;

import com.common.AjaxResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.User;
import com.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @description: 用户Controller
 * @Author: shixinyu
 * @Date: 2021/10/9 10:12
 */
@Controller
@RequestMapping("/user")
public class UserController {
    Logger logger = (Logger) LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService userService;
    /**
     * @Description: 查询用户
     * @Param: []
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/9
     */
    @RequestMapping("/query")
    @ResponseBody
    public List<User> query(){
        return userService.query(null);
    }
    /**
     * @Description: 普通传参
     * @Param: [id, name]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/9
     */

    @RequestMapping("/queryOne")
    @ResponseBody
    public List<User> queryOne(String id,String name){
        logger.debug("id:"+id+";name"+name);
        return userService.query(null);
    }
    /**
     * @Description: 对象传参
     * @Param: [id, name]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/9
     */

    @RequestMapping("/queryTwo")
    @ResponseBody
    public List<User> queryTwo(User user){
        logger.debug("user:"+user.toString());
        return userService.query(null);
    }
    /**
     * @Description: @RequestParam 传参
     * @Param: [user]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/9
     */

    @RequestMapping("/queryThree")
    @ResponseBody
    public List<User> queryThree(@RequestParam("userName") String name, @RequestParam("userId")String id){
        logger.debug("id:"+id+";name"+name);
        return userService.query(null);
    }
    /**
     * @Description: HttpServletRequest 传参
     * @Param: [request]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @RequestMapping("/queryFour")
    @ResponseBody
    public List<User> queryFour(HttpServletRequest request){
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        logger.debug("id:"+id+";name"+name);
        return userService.query(null);
    }
    /**
     * @Description: @PathVariable 获取路径中的参数
     * @Param: [id, name]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @RequestMapping("/queryFive/{id}/{name}")
    @ResponseBody
    public List<User> queryFive(@PathVariable String id, @PathVariable String name){
        logger.debug("id:"+id+";name"+name);
        return userService.query(null);
    }
    /**
     * @Description: @RequestBody传递json
     * @Param: [user]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @RequestMapping(value = "/querySix",method = RequestMethod.POST)
    @ResponseBody
    public List<User> querySix(@RequestBody User user){
        logger.debug("user:"+user.toString());
        return userService.query(null);
    }
    /**
     * @Description: 根据条件查询用户
     * @Param: [user]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @RequestMapping(value = "/queryByNameAndId",method = RequestMethod.POST)
    @ResponseBody
    public List<User> queryByNameAndId(@RequestBody User user){
        logger.debug("user:"+user.toString());
        return userService.query(user);
    }
    /**
     * @Description: 删除
     * @Param: [id]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @RequestMapping(value = "/deleteUser")
    @ResponseBody
    public AjaxResult deleteUser(String id){
        return AjaxResult.toAjax(userService.deleteUser(id));
    }
    /**
     * @Description: 新增
     * @Param: [user]
     * @return: java.util.List<com.pojo.User>
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @RequestMapping("/addUser")
    @ResponseBody
    public AjaxResult addUser(@RequestBody User user){

        return AjaxResult.toAjax(userService.addUser(user));
    }
    /**
     * @Description: 修改用户信息
     * @Param: [id]
     * @return: int
     * @Author: shixinyu
     * @Date: 2021/10/11
     */

    @RequestMapping(value = "/updateUser")
    @ResponseBody
    public int updateUser(@RequestBody User user){
        return userService.updateUser(user);
    }

    /**
     * @Description: 查询用户列表
     * @Param: []
     * @return: java.lang.String
     * @Author: shixinyu
     * @Date: 2021/10/14
     */

    @RequestMapping("/selectUserList")
    public String selectUserList(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum, Model model){
        //1.设置pageHelper的参数，第几页，每页几条
        PageHelper.startPage(pageNum,5);
        //2.查询数据库
        List<User> result = userService.query(null);
        //3.把查询到的数据交给pageInfo处理，他会自动分配一共多少页等各种分页信息
        PageInfo page = new PageInfo(result);
        model.addAttribute("pageInfo",page);
        return "list";
    }
    /**
     * @Description: 用json形式返回用户信息
     * @Param: [pageNum]
     * @return: com.github.pagehelper.PageInfo
     * @Author: shixinyu
     * @Date: 2021/10/15
     */

    @RequestMapping("/selectUserListForJson")
    @ResponseBody
    public AjaxResult selectUserListForJson(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum,User user){
        //1.设置pageHelper的参数，第几页，每页几条
        PageHelper.startPage(pageNum,5);
        //2.查询数据库
        List<User> result = userService.query(user);
        //3.把查询到的数据交给pageInfo处理，他会自动分配一共多少页等各种分页信息
        PageInfo page = new PageInfo(result);
        return AjaxResult.success("查询成功",page);
    }
    /**
     * @Description: 批量删除
     * @Param: [ids]
     * @return: com.common.AjaxResult
     * @Author: shixinyu
     * @Date: 2021/10/19
     */

    @RequestMapping(value = "/deleteUserPl")
    @ResponseBody
    public AjaxResult deleteUserPl(String[] ids){
        return AjaxResult.toAjax(userService.deleteUserPl(ids));
    }

    //登录功能
    @RequestMapping("/login")
    @ResponseBody
    public AjaxResult login(@RequestBody User user,HttpServletRequest request){

       return userService.login(user,request);
    }
    //注册功能

    @RequestMapping(value = "/register")
    @ResponseBody
    public Object register(@RequestBody User user, HttpServletRequest request) {

       return userService.register(user,request);
    }


}


