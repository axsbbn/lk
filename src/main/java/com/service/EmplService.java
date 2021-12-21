package com.service;

import com.pojo.Employee;

import java.util.List;

/**
 * @description:
 * @Author: zjh
 * @Date: 2021/10/19 15:34
 */
public interface EmplService {
    List<Employee> query(Employee employee);

    int addEmpl(Employee employee);

    int deleteEmpl(String id);

    int deleteEmplPl(String[] ids);
}
