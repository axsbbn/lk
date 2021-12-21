package com.service;

import com.pojo.EmployeeInfo;

import java.util.List;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2215:49
 */
public interface EmployeeInfoService {
    List<EmployeeInfo> query(EmployeeInfo employeeInfo);

    int addinfo(EmployeeInfo employeeInfo);

}
