package com.service.Impl;

import com.dao.EmplDao;
import com.pojo.Employee;
import com.service.EmplService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @Author: zjh
 * @Date: 2021/10/19 15:35
 */
@Service
public class EmplServiceImpl implements EmplService {
    @Autowired
    private EmplDao emplDao;
    @Override
    public List<Employee> query(Employee employee) {
        return emplDao.query(employee);
    }

    @Override
    public int addEmpl(Employee employee) {
        return emplDao.addEmpl(employee);
    }

    @Override
    public int deleteEmpl(String id) {
        return emplDao.deleteEmpl(id);
    }

    @Override
    public int deleteEmplPl(String[] ids) {
        return emplDao.deleteEmplPl(ids);
    }
}

