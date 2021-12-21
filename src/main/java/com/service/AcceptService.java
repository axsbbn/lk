package com.service;

import com.common.AjaxResult;
import com.pojo.Accept;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2422:27
 */
public interface AcceptService {
    AjaxResult list(Integer pageNum,Accept accept);

    AjaxResult pass(Accept accept);

    AjaxResult initAccept(String accId,String infoId,String empId);
}
