<%--
  Created by IntelliJ IDEA.
  User: 86149
  Date: 2021/11/25
  Time: 13:30
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
    <script type="text/javascript" src="${APP_PATH}/static/bootstrapValidator/bootstrapValidator.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrapValidator/bootstrapValidator.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrapSelect/js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrapSelect/js/i18n/defaults-zh_CN.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrapSelect/css/bootstrap-select.min.css">

    <title>入职合同</title>
    <style type="text/css">
        .fromrow{
            padding: 10px 20px;
            text-align-last: justify;
            text-align: justify;
        }
    </style>
</head>
<body>
<%--审核模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <%--标题部分--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">入职资料</h4>
            </div>
            <%--内容部分--%>
            <div class="modal-body">
                <div>
                    <form class="form-horizontal" id="contractForm">
                        <%--姓名--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <select class="form-control selectpicker" id="name" name="name" data-live-search="true" data-style="btn-primary">
                                </select>
                            </div>
                        </div>
                        <%--身份证号--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">身份证号</label>
                            <div class="col-sm-10">
                                <input type="text" name="cardid" class="form-control" id="cardid" readonly>
                            </div>
                        </div>
                        <%--出生日期--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">部门</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="department" readonly>
                                    <option value="">暂无</option>
                                    <option value="1">销售部</option>
                                    <option value="2">技术部</option>
                                    <option value="3">管理部</option>
                                    <option value="4">后勤部</option>
                                    <option value="5">人事部</option>
                                </select>
                            </div>
                        </div>
                        <%--合同类型--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">合同类型</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="type" name="type">
                                    <option value="">全部</option>
                                    <option value="1">入职合同</option>
                                    <option value="2">离职合同</option>
                                </select>
                            </div>
                        </div>
                        <%--合同期限--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">合同期限(年)</label>
                            <div class="col-sm-10">
                                <input type="number" name="deteLine" class="form-control" id="deteLine">
                            </div>
                        </div>
                        <%--生效日期--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">生效日期</label>
                            <div class="col-sm-10">
                                <input type="date" name="effectiveDate" class="form-control" id="effectiveDate">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <%--按钮部分--%>
            <div class="modal-footer butt-foot" >
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>--%>
                    <button type="button" class="btn btn-success" onclick="addCont()">发起签订</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
   <div class="row">
      <h1 class="col-md-12 ">入职合同签订</h1>
        </div>
          <div class="row">
            <div class="col-md-8">
               <form class="form-inline">
                   <div class="form-group">
                        <label for="param_name">姓名</label>
                        <input type="text" class="form-control" id="param_name" placeholder="请输入姓名">
                   </div>
                   <div class="form-group">
                       <label for="param_status">合同状态</label>
                       <select class="form-control" id="param_status">
                            <option value="">全部</option>
                            <option value="0">未签订</option>
                            <option value="1">生效中</option>
                            <option value="2">已过期</option>
                        </select>
                    </div>
                   <div class="form-group">
                       <label for="param_status">合同类型</label>
                       <select class="form-control" id="param_type">
                           <option value="">全部</option>
                           <option value="1">入职合同</option>
                           <option value="2">离职合同</option>
                       </select>
                   </div>
                <button type="button" class="btn btn-success" onclick="selectList()">查询</button>
            </form>
        </div>
        <div class="col-md-4">
            <button class="btn btn-primary" type="button" onclick="addContract()">签订合同</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emplTable">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="checkAll" onchange="checkAllEmpl()"></th>
                        <th>序号</th>
                        <th>员工姓名</th>
                        <th>合同类型</th>
                        <th>发起签订时间</th>
                        <th>签订状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%--分页导航栏--%>
    <div class="row">
        <div class="col-md-6" id="nav_info"></div>
        <div class="col-md-4 col-md-offset-2" id="nav_tab"></div>
    </div>
</div>
<script type="text/javascript">
    $(function (){
        //查询合同列表
        selectList(1);
        //查询员工下拉框
        selectEmployee();
        //监听下拉框变化
        $('#name').change(function() {
            if ($(this).val()){
                for (var i=0;i<emplist.length;i++){
                    if (emplist[i].emplId == $(this).val()){
                        $("#cardid").val(emplist[i].cardId);
                        $("#department").val(emplist[i].department);
                        break;
                    }
                }
            }else{
                $("#cardid").val("");
                $("#department").val("");
            }
        });
    });
    //员工下拉框数据
    var emplist = [];
    function createTableDate(result){
        var list = result.data.list;
        var html = "";

        for (var i=0;i<list.length;i++){

            var bean = list[i];
            html += '<tr>';
            html += '    <td><input class="checkEmpl" type="checkbox" id='+bean.id+'></td>';
            html += '    <td>'+(i+1)+'</td>';
            html += '    <td>'+bean.name+'</td>';
            html += '    <td>'+formatType(bean.type)+'</td>';
            html += '    <td>'+bean.addTime+'</td>';
            html += '    <td>'+formatStatus(bean.status)+'</td>';
            html += '    <td>';
            html += '    <button class="btn btn-primary btn-sm" type="button" onclick="downLoadContract(&apos;'+bean.filepath+'&apos;)">';
            html += '        <span class="glyphicon glyphicon-circle-arrow-down">下载</span>';
            html += '    </button>';
            if (bean.status == '1'){
                html += '    <button class="btn btn-warning btn-sm" type="button" onclick="updateStatus('+bean.id+','+result.data.pageNum+')">';
                html += '        <span class="glyphicon glyphicon-trash">失效</span>';
                html += '    </button>';
            }else if (bean.status == '2'){
                html += '    <button class="btn btn-danger btn-sm" type="button" onclick="deleteById('+bean.id+','+result.data.pageNum+')">';
                html += '        <span class="glyphicon glyphicon-remove">删除</span>';
                html += '    </button>';
            }

            html += '        </td>';
            html += '       </tr>';
        }
        $("#emplTable tbody").html(html);
    }

    function buileNavDate(result){
        var html = "当前页码第"+result.data.pageNum+"页,总共"+result.data.pages+"页,总共"+result.data.total+"条数据";
        $("#nav_info").html(html);
    }

    function buileNav(result){
        var pageArray=result.data.navigatepageNums;
        var html = "";
        html += '<nav aria-label="Page navigation example">';
        html += '  <ul class="pagination">';
        html += '  <li onclick="selectEmplInfo(1)"><a href="#">首页</a></li>';

        if (result.data.hasPreviousPage){
            html += '   <li onclick="selectEmplInfo('+result.data.prePage+')"> <a href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span> </a> </li>';
        }

        for (var i = 0;i<=pageArray.length-1;i++){
            if (result.data.pageNum == pageArray[i]){
                html += '  <li class="active"><a class="page-link" href="#">'+pageArray[i]+'</a></li>';
            }else {
                html += '  <li onclick="selectEmplInfo('+pageArray[i]+')"><a href="#">'+pageArray[i]+'</a></li>';
            }
        }

        if (result.data.hasNextPage){
            html += '  <li onclick="selectEmplInfo('+result.data.nextPage+')"> <a href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span> </a> </li>';
        }
        html += '  <li onclick="selectEmplInfo('+result.data.pages+')"><a href="#">尾页</a></li>';
        html += ' </ul>';
        html += '  </nav>';
        $("#nav_tab").html(html);
    }

    function selectList(pageNum){
        var name = $('#param_name').val();
        var status =  $('#param_status').val();
        var type = $('#param_type').val();
        $.ajax({
            url:"${APP_PATH}/contract/selectList",
            data:{
                pageNum: pageNum,
                name: name,
                status: status,
                type: type
            },
            type:"GET",
            success : function (result){
                createTableDate(result);
                buileNavDate(result);
                buileNav(result);
            }
        });
    }
    //关闭模态框触发的事件
    $("#myModal").on('hidden.bs.modal',function () {
        //重置输入框的值
        $('#name').val()
        $("#cardid").val("");
        $("#department").val("");
        $("#type").val("");
        $("#deteLine").val("");
        $("#effectiveDate").val("");
        //重置表单校验组件
        $("#contractForm").data('bootstrapValidator').destroy();
        $('#contractForm').data('bootstrapValidator',null);

    })



    function formatStatus(status){
        if (status == '1'){
            //已生成
            return '已生成';
        }else if (status == '2'){
            //已失效
            return '已失效';
        }else{
            return '';
        }
    }
    function formatType(type){
        if (type == '1'){
            return '入职';
        }else if (type == '2'){
            return '离职';
        }else{
            return '';
        }
    }
    //发起合同签订
    function addContract(id) {
        $('#myModal').modal('show');
        //初始化表单校验
        $('#contractForm').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name : {
                    validators :{
                        notEmpty: {
                            message : '员工姓名不能为空'
                        }
                    }
                },
                deteLine: {
                    validators :{
                        notEmpty: {
                            message : '合同期限不能为空'
                        }
                    }
                },
                effectiveDate: {
                    validators :{
                        notEmpty: {
                            message : '生效日期不能为空'
                        }
                    }
                },
                type: {
                    validators :{
                        notEmpty: {
                            message : '合同类型不能为空'
                        }
                    }
                }
            }
        });
    }

    function addCont(){
        var bootstrapValidator = $("#contractForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()){
            var bean = makeBean();
            $.ajax({
                url:"${APP_PATH}/contract/addContract",
                data: JSON.stringify(bean),
                contentType : 'application/json',
                type:"POST",
                success : function (result){
                    if (result.code == 200){
                        alert(result.msg);
                        $('#myModal').modal('hide');
                        selectList(1);
                    }else{
                        alert(result.msg);
                    }

                }
            });
        }

    }
    //初始化员工下拉框
    function selectEmployee() {
        $.ajax({
            url:"${APP_PATH}/empl/selectList",
            data:{
            },
            type:"GET",
            success : function (result){

                $("#name").append("<option value=''>请选择</option>");//添加第一个option值
                emplist = result.data;
                for(var i=0;i<emplist.length;i++){
                    $("#name").append("<option value='"+emplist[i].emplId+"'>"+emplist[i].emplName+"</option>");//添加第一个option值
                }
                $('.selectpicker').selectpicker('refresh');
                $('.selectpicker').selectpicker('render');
            }
        });
    }
    //封装对象
    function makeBean(){
        var bean={};
        bean.employeeId = $('#name').val()
        bean.type = $("#type").val();
        bean.deteLine = $("#deteLine").val();
        bean.effectiveDate = $("#effectiveDate").val();
        bean.status = "1";
        bean.isDelete = '0';
        return bean;
    }
    //下载合同
    function downLoadContract(filepath) {
        window.location.href = "${APP_PATH}/static/"+filepath;
    }
    //已失效
    function updateStatus(id,pageNum){
        $.ajax({
            url:"${APP_PATH}/contract/updateStatus",
            data:{
                id:id
            },
            type:"GET",
            success : function (result){
                if (result.code == 200){
                    selectList(pageNum);
                }else{
                    alert(result.msg);
                }
            }
        });
    }
    //删除
    function deleteById(id,pageNum){
        $.ajax({
            url:"${APP_PATH}/contract/deleteById",
            data:{
                id:id
            },
            type:"GET",
            success : function (result){
                if (result.code == 200){
                    selectList(pageNum);
                }else{
                    alert(result.msg);
                }
            }
        });
    }
</script>
</body>
</html>
