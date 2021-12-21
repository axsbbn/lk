<%--
  Created by IntelliJ IDEA.
  User: 86149
  Date: 2021/11/20
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/js/echarts.min.js"></script>
    <title>Title</title>
    <style type="text/css">
        .count-div{
            margin-top: 30px;
            background-color: #edb34a;
            margin-left: 20px;
            height: 100px;
            border-radius: 10px;
            text-align: center;
            color: #fff;
            font-size: 17px;
            line-height: 50px;
            font-weight: bold;
        }
        .count{
            font-size: 30px;
        }
    </style>
</head>
<body>
    <%--<h1>欢迎光临</h1>
    <div>通知：</div>
    <div>即日起，新员工入职，请hr把下方二维码发送给新入职员工，用微信扫描二维码填写入职材料！</div>
    <div>入职材料填写完毕，请hr尽快登录员工管理系统审核，谢谢配合</div>
    <div>http://localhost:8082/eshop/view/empInfo.jsp</div>
    <div>
        <img src="${APP_PATH}/static/img/baiduewm.png">
    </div>--%>
    <div class="container">
        <%--数值统计部分--%>
        <div class="row">
            <div class="col-md-3 count-div">
                <div class="count-text">累计入职人数</div>
                <div class="count rzrs"></div>
            </div>
            <div class="col-md-3 count-div" style="background-color: #69a6b8;">
                <div class="count-text">累计离职人数</div>
                <div class="count lzrs"></div>
            </div>
            <div class="col-md-3 count-div" style="background-color: #75ce75;">
                <div class="count-text">累计签订合同数</div>
                <div class="count ljrs"></div>
            </div>
        </div>
         <%--折线图部分--%>
        <div class="row" style="margin-top: 20px;">
            <!-- 为 ECharts 准备一个定义了宽高的 DOM -->
            <div id="main" style="width: 100%;height:400px;"></div>
        </div>
            <%--通知部分--%>
        <div class="row" style="margin-top: 20px;">
            <div class="col-md-8" style="font-size: 17px;">
                <div style="font-size: 20px;font-weight: bold;">通知:</div>
                <div>即日起，新员工入职，请hr把下方二维码发送给新入职员工，用微信扫描二维码填写入职材料！</div>
                <div>入职材料填写完毕，请hr尽快登录员工管理系统审核，谢谢配合</div>
                <div>http://localhost:8082/eshop/view/empInfo.jsp</div>
            </div>
            <div class="col-md-4">
                <img src="${APP_PATH}/static/img/baiduewm.png" style="width: 150px;">
            </div>
        </div>
    </div>
<script type="text/javascript">
    $(function () {
        //初始化数据
        initData();
    })
    //初始化数据
    function initData() {
        $.ajax({
            url:"${APP_PATH}/contract/selectCount",
            data: {},
            contentType : 'application/json',
            type: "GET",
            success : function (result) {
                if (result.code == 200){
                    //console.log(result.data);
                    $(".rzrs").html(result.data.count.rzCount);
                    $(".lzrs").html(result.data.count.lzCount);
                    $(".ljrs").html(result.data.count.count);
                    buildZxt(result.data);
                }else{
                    alert(result.msg);
                }
            }
        });
    }
    function buildZxt(info) {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: ''
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['入职人数', '离职人数']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                data: info.month
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    name: '入职人数',
                    type: 'line',
                    stack: 'Total',
                    data: info.rz
                },
                {
                    name: '离职人数',
                    type: 'line',
                    stack: 'Total',
                    data: info.lz
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
</script>
</body>
</html>
