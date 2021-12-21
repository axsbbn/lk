package com.dao;

import com.pojo.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description:
 * @Author: zjh
 * @Date: 2021/10/19 15:34
 */
public interface EmplDao {
    List<Employee> query(Employee employee);

    int addEmpl(Employee employee);

    int deleteEmpl(String id);

    int deleteEmplPl(@Param("ids") String[] ids);
}