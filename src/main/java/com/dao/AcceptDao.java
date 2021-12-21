package com.dao;

import com.pojo.Accept;
import com.pojo.EmployeeInfo;

import java.util.List;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2414:25
 */
public interface AcceptDao {
    int insertAcceptor(Accept accept);

    List<EmployeeInfo> query(Accept accept);

    int updatePass(Accept accept);

    Accept selectById(String id);
}
