package com.pojo;

import lombok.Data;

/**
 * @description 审核表
 * @Author:86149
 * @Date:2021/11/2414:11
 */
@Data
public class Accept {
    private String id;
    private String infoId;
    private String status;
    private String content;
    private String userId;
    private String addTime;
    private String acceptTime;
    private String name;

}
