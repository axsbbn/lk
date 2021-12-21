package com.dao;

import com.pojo.Contract;
import com.pojo.ContractCount;
import com.pojo.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description
 * @Author:86149
 * @Date:2021/12/113:28
 */
public interface ContractDao {
    //查询列表
    List<Contract> selectList(Contract contract);

    int addCont(Contract contract);

    int updateFilepath(Contract contract);

    int updateStatus(@Param("id") String id);

    int deleteById(@Param("id")String id);

    ContractCount selectCount(@Param("time")String time);

    List<String> selectMonth();
}
