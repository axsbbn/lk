package com.dao;

import com.pojo.ContractCount;
import com.pojo.EmployeeInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description
 * @Author:86149
 * @Date:2021/11/2215:50
 */
public interface EmployeeInfoDao {
    int addInfo(EmployeeInfo employeeInfo);

    List<EmployeeInfo> selectList(EmployeeInfo employeeInfo);

    EmployeeInfo selectById(@Param("id")String id,@Param("emplId")String empId);

    int updateEid(@Param("infoId") String infoId, @Param("emplId")String emplId);


}
