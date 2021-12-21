package com.service;

import com.common.AjaxResult;
import com.pojo.Contract;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @description 合同Service
 * @Author:86149
 * @Date:2021/12/113:23
 */
public interface ContractService {
    List<Contract> query(Contract contract);

    AjaxResult addCont(Contract contract, HttpServletRequest request)throws Exception;

    AjaxResult updateStatus(String id);

    AjaxResult deleteById(String id);

    AjaxResult selectCount();
}
