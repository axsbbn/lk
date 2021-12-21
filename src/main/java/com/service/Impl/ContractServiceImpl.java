package com.service.Impl;

import com.common.AjaxResult;
import com.common.WordUtil;
import com.dao.ContractDao;
import com.dao.EmployeeInfoDao;
import com.pojo.Contract;
import com.pojo.ContractCount;
import com.pojo.EmployeeInfo;
import com.service.ContractService;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.*;

/**
 * @description 合同ServiceImpl
 * @Author:86149
 * @Date:2021/12/113:23
 */
@Service
public class ContractServiceImpl implements ContractService {
    @Autowired
    private ContractDao contractDao;
    @Autowired
    private EmployeeInfoDao employeeInfoDao;
    @Override
    public List<Contract> query(Contract contract) {
        List<Contract> list = contractDao.selectList(contract);
        return list;
    }

    @Override
    public AjaxResult addCont(Contract contract, HttpServletRequest request)throws Exception {
        //判断当前员工当前类型的合同是否存在
        List<Contract> list = contractDao.selectList(contract);
        if (list.size()>0){
            return AjaxResult.error("当前员工已经签署过合同");
        }
        //保存到合同表
        int result = contractDao.addCont(contract);
        //根据word模板生成合同
        String wordFilePath = createWordFile(contract,request);
        //更新文件地址保存到数据库
        contract.setFilepath(wordFilePath);
        result += contractDao.updateFilepath(contract);
        System.out.println(wordFilePath);
        return AjaxResult.toAjax(result);
    }

    @Override
    public AjaxResult updateStatus(String id) {
        int result = contractDao.updateStatus(id);
        return AjaxResult.toAjax(result);
    }

    @Override
    public AjaxResult deleteById(String id) {
        int result = contractDao.deleteById(id);
        return AjaxResult.toAjax(result);
    }



    /**
    *@Description: 根据模板生产word
    *@param:[type]
    *@return:void
    *@Author:shixinyu
    *@Date:2021/12/6
    */
    private String createWordFile(Contract contract, HttpServletRequest request) throws Exception{
        //根据员工主键查询员工基本信息
        EmployeeInfo empInfo = employeeInfoDao.selectById(null,contract.getEmployeeId());
        String type = contract.getType();
        String contentPath = request.getSession().getServletContext().getRealPath("static/");
        String tempPath = "";
        if ("1".equals(type)){
            //入职模板
            tempPath = contentPath + "file/temp/rzmb.docx";
        }else if ("2".equals(type)){
            //离职模板
            tempPath = contentPath + "file/temp/lzmb.docx";
        }
        //定义参数
        Map<String,Object> mapObject = new HashMap<>();
        mapObject.put("{name}",empInfo.getName());
        mapObject.put("{sex}",empInfo.getSex().equals("0")?"男":"女");
        mapObject.put("{cardid}",empInfo.getCardId());
        mapObject.put("{address}",empInfo.getAddress());
        mapObject.put("{effectivedate}",contract.getEffectiveDate());
        mapObject.put("{deteline}",contract.getDeteLine());
        Calendar rightNow = Calendar.getInstance();
        Integer year = rightNow.get(Calendar.YEAR);
        Integer month = rightNow.get(Calendar.MONTH)+1;
        Integer day = rightNow.get(rightNow.DAY_OF_MONTH);
        mapObject.put("{year}",year+"");
        mapObject.put("{month}",month+"");
        mapObject.put("{day}",day+"");
        //定义生成的文件地址
        String wordFileName = UUID.randomUUID() +".docx";
        String wordFilePath = contentPath + "file/qdht/"+ wordFileName;
        XWPFDocument doc = WordUtil.generateWord(mapObject,tempPath);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        doc.write(baos);
        byte[] bytes =  baos.toByteArray();
        baos.close();

        //写入word表格中;
        String serverpath=contentPath + "file/qdht/";
        File storage=new File(serverpath);
        //判断当前目录是否存在
        if (!storage.exists()){
            //不存在。创建一个目录
            storage.mkdirs();
        }
        //创建目标文件
        File targetFile=new File(wordFilePath);
        OutputStream out = new FileOutputStream(targetFile);
        InputStream is = new ByteArrayInputStream(bytes);
        byte[] buff = new byte[1024];
        int len = 0;
        while ((len = is.read(buff)) != -1) {
            out.write(buff, 0, len);
        }
        is.close();
        out.close();
        return "/file/qdht/"+ wordFileName;
    }

    @Override
    public AjaxResult selectCount() {
        Map map = new HashMap();
        //查询数量
        ContractCount count = contractDao.selectCount(null);
        //查询每个月的入职人数离职人数
        //查询今年的12个月
        List<String> months = contractDao.selectMonth();
        String[] monthStr = new String[12];
        String[] rz = new String[12];
        String[] lz = new String[12];
        for (int i=0;i<months.size();i++){
            String month = months.get(i);
            monthStr[i] = month;
            ContractCount countMonth = contractDao.selectCount(month);
            rz[i] = countMonth.getRzCount();
            lz[i] = countMonth.getLzCount();
        }
        map.put("month",monthStr);
        map.put("lz",lz);
        map.put("rz",rz);
        map.put("count",count);
        return AjaxResult.success(map);
    }

}
