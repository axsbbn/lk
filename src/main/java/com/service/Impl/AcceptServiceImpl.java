package com.service.Impl;

import com.common.AjaxResult;
import com.dao.AcceptDao;
import com.dao.EmplDao;
import com.dao.EmployeeInfoDao;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Accept;
import com.pojo.Employee;
import com.pojo.EmployeeInfo;
import com.service.AcceptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2422:28
 */
@Service
public class AcceptServiceImpl implements AcceptService {
    @Autowired
    private AcceptDao acceptDao;
    @Autowired
    private EmplDao emplDao;
    @Autowired
    private EmployeeInfoDao employeeInfoDao;
    /**
    *@Description:查询审核列表
    *@param:[accept]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/11/24
    */
    @Override
    public AjaxResult list(Integer pageNum,Accept accept) {
        PageHelper.startPage(pageNum, 10);
        List<EmployeeInfo> result = acceptDao.query(accept);
        PageInfo page = new PageInfo(result);
        return AjaxResult.success("查询成功", page);
    }
    /**
    *@Description: 审核
    *@param:[accept]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/11/29
    */
    @Override
    public AjaxResult pass(Accept accept) {
        int result = 0;
        //查询入职信息
        EmployeeInfo info= employeeInfoDao.selectById(accept.getInfoId(),null);
        //更新审核单状态
        result += acceptDao.updatePass(accept);
        //保存员工到员工表
        Employee employee = new Employee();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        employee.setProductDate(sf.format(new Date()));
        employee.setEmplName(info.getName());
        employee.setSex(info.getSex());
        employee.setIsDelete("0");
        result += emplDao.addEmpl(employee);
        //更新入职信息表的员工主键
        result += employeeInfoDao.updateEid(accept.getInfoId(),employee.getEmplId());
        return AjaxResult.toAjax(result);
    }

    @Override
    public AjaxResult initAccept(String accId,String infoId,String empId) {
        //查询入职信息
        EmployeeInfo info= employeeInfoDao.selectById(infoId,empId);
        //查询审核信息
        Accept accept = acceptDao.selectById(accId);
        Map map = new HashMap();
        map.put("info",info);
        map.put("accept",accept);
        return AjaxResult.success(map);
    }
}
