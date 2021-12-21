package com.controller;

import com.common.AjaxResult;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pojo.Contract;
import com.pojo.Employee;
import com.pojo.EmployeeInfo;
import com.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @description 合同Controller
 * @Author:86149
 * @Date:2021/12/113:22
 */
@RequestMapping("/contract")
@RestController
public class ContractController {
    @Autowired
    private ContractService contractService;
    @GetMapping("/selectList")
    public AjaxResult selectList(@RequestParam(value = "pageNum", defaultValue = "1")Integer pageNum, Contract contract) {
        PageHelper.startPage(pageNum, 10);
        List<Contract> result = contractService.query(contract);
        PageInfo page = new PageInfo(result);
        return AjaxResult.success("查询成功", page);
    }
    /**
    *@Description: 发起签订
    *@param:[employeeInfo]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/12/2
    */
    @PostMapping("/addContract")
    public AjaxResult addCont(@RequestBody Contract contract, HttpServletRequest request)throws Exception{
        return contractService.addCont(contract,request);
    }
    /**
    *@Description: 已经失效
    *@param:[id]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/12/12
    */
    @GetMapping("/updateStatus")
    public AjaxResult updateStatus(String id) {
        return contractService.updateStatus(id);
    }
    /**
    *@Description: 删除
    *@param:[id]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/12/12
    */
    @GetMapping("/deleteById")
    public AjaxResult deleteById(String id) {
        return contractService.deleteById(id);
    }
    @GetMapping("/selectCount")
    public AjaxResult selectCount() {
        return contractService.selectCount();
    }
}

