package com.controller;

import com.common.AjaxResult;
import com.pojo.Accept;
import com.service.AcceptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2422:26
 */
@RequestMapping("/accept")
@RestController
public class AcceptController {
    @Autowired
    private AcceptService acceptService;
    /**
    *@Description: 查询审核列表
    *@param:[]
    *@return:java.lang.Object
    *@Author:shixinyu
    *@Date:2021/11/24
    */
    @GetMapping("/list")
    public AjaxResult list(@RequestParam(value = "pageNum", defaultValue = "1")
                                       Integer pageNum, Accept accept){
        return acceptService.list(pageNum,accept);
    }
    /**
    *@Description: 审核
    *@param:[accept]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/11/29
    */
    @PostMapping("/pass")
    public AjaxResult pass(@RequestBody Accept accept){
        return acceptService.pass(accept);
    }
    /**
    *@Description: 初始化审核详情
    *@param:[acceptId]
    *@return:com.common.AjaxResult
    *@Author:shixinyu
    *@Date:2021/11/30
    */
    @GetMapping("/initAccept")
    public AjaxResult initAccept(String accId,String infoId,String empId){
        return acceptService.initAccept(accId,infoId,empId);
    }
}
