package com.service.Impl;

import com.dao.AcceptDao;
import com.dao.EmplDao;
import com.dao.EmployeeInfoDao;
import com.pojo.Accept;
import com.pojo.EmployeeInfo;
import com.service.EmployeeInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2215:49
 */
@Service
public class EmployeeInfoServiceImpl implements EmployeeInfoService {
    @Autowired
    private EmployeeInfoDao employeeInfoDao;
    @Autowired
    private AcceptDao acceptDao;

    @Override
    public List<EmployeeInfo> query(EmployeeInfo employeeInfo) {
        List<EmployeeInfo> list = employeeInfoDao.selectList(employeeInfo);
        return list;
    }

    @Override
    public int addinfo(EmployeeInfo employeeInfo) {
        //保存入职资料
        int result = employeeInfoDao.addInfo(employeeInfo);
        //保存审核意见 保存到accept表
        Accept accept = new Accept();
        accept.setUserId("");
        accept.setContent("");
        accept.setInfoId(employeeInfo.getId());
        accept.setStatus("0");
        result += acceptDao.insertAcceptor(accept);
        return result;
    }
}
