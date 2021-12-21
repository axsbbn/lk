package com.pojo;

import lombok.Data;

/**
 * @description 合同
 * @Author:86149
 * @Date:2021/11/3020:11
 */
@Data
public class Contract {
    private String id;
    private String employeeId;
    private String type;
    private String addTime;
    private String deteLine;
    private String status;
    private String effectiveDate;
    private String deleted;
    private String name;
    private String filepath;
}
