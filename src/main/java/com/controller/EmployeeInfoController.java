package com.controller;

import com.common.AjaxResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Employee;
import com.pojo.EmployeeInfo;
import com.service.EmplService;
import com.service.EmployeeInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2215:32
 */
@RestController
@RequestMapping("/employeeinfo")
public class EmployeeInfoController {
    @Autowired
    private EmployeeInfoService employeeInfoService;

    @GetMapping("/selectList")
    public AjaxResult selectEplListForJson(@RequestParam(value = "pageNum", defaultValue = "1")
                                                   Integer pageNum, EmployeeInfo employeeInfo) {
        PageHelper.startPage(pageNum, 10);
        List<EmployeeInfo> result = employeeInfoService.query(employeeInfo);
        PageInfo page = new PageInfo(result);
        return AjaxResult.success("查询成功", page);
    }

    @RequestMapping("/addinfo")
    public AjaxResult addinfo(@RequestBody EmployeeInfo employeeInfo) {
        return AjaxResult.toAjax(employeeInfoService.addinfo(employeeInfo));
    }
}