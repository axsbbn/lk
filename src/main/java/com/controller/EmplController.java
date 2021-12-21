package com.controller;

import com.common.AjaxResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Employee;
import com.pojo.User;
import com.service.EmplService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @description:
 * @Author: zjh
 * @Date: 2021/10/19 15:33
 */

@RestController

@RequestMapping("/empl")
public class EmplController {
    @Autowired
    private EmplService emplService;
    @RequestMapping("/selectEplListForJson")
    public AjaxResult selectEplListForJson(@RequestParam(value = "pageNum",defaultValue = "1")
                                                   Integer pageNum,Employee employee){
        PageHelper.startPage(pageNum,10);
        List<Employee> result = emplService.query(employee);
        PageInfo page=new PageInfo(result);
        return AjaxResult.success("查询成功",page);

    }
    @RequestMapping("/addEmpl")
    public AjaxResult addEmpl(@RequestBody Employee employee){
        return AjaxResult.toAjax(emplService.addEmpl(employee));
    }
    @RequestMapping("/deleteEmpl")
    public AjaxResult deleteEmpl(String id){
        return AjaxResult.toAjax(emplService.deleteEmpl(id));
    }

    @RequestMapping("/deleteEmplPl")
    public AjaxResult deleteEmplPl(String[] ids){
        return AjaxResult.toAjax(emplService.deleteEmplPl(ids));
    }
    @RequestMapping("/selectList")
    public AjaxResult selectEplListForJson(Employee employee){
        List<Employee> result = emplService.query(employee);
        return AjaxResult.success(result);

    }
}
