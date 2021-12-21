package com.pojo;

/**
 * @description: 用户实体类
 * @Author: Lenovo
 * @Date: 2021/10/9 9:31
 */
public class User {
    //用户主键
    private String id;
    //用户姓名
    private String userName;
    //用户密码
    private String password;
    //性别
    private String sex;
    //电话
    private String mobile;
    //删除标志
    private String isDelete;
    //插入时间
    private String createTime;




    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
