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
    <title>入职资料审核</title>
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
                    <form class="form-inline">
                        <%--审核表主键--%>
                        <input type="hidden" id="id">
                        <%--入职信息表主键--%>
                        <input type="hidden" id="infoId">
                        <div class="fromrow row">
                            <div class="form-group ">
                                <label>姓名</label>
                                <input type="text" class="form-control" id="name" readonly>
                            </div>
                            <div class="form-group ">
                                <label>性别</label>
                                <input type="text" class="form-control" id="sex" readonly>
                            </div>
                            <div class="form-group ">
                                <label>年龄</label>
                                <input type="text" class="form-control" id="age" readonly>
                            </div>
                        </div>
                        <div class="fromrow row">
                            <div class="form-group " >
                                <label>身份证号</label>
                                <input type="text" class="form-control" id="cardId" readonly>
                            </div>
                            <div class="form-group ">
                                <label>是否已婚</label>
                                <input type="text" class="form-control" id="marry" readonly>
                            </div>
                            <div class="form-group ">
                                <label>是否有传染病</label>
                                <input type="text" class="form-control" id="healthy" readonly>
                            </div>
                        </div>
                        <div class="fromrow row">
                            <div class="form-group ">
                                <label>手机号</label>
                                <input type="text" class="form-control" id="mobile" readonly>
                            </div>
                            <div class="form-group  ">
                                <label>籍贯</label>
                                <input type="text" class="form-control" id="nativee" readonly>
                            </div>
                            <div class="form-group ">
                                <label>现住址</label>
                                <input type="text" class="form-control" id="address" readonly>
                            </div>
                        </div>
                        <div class="fromrow row">
                            <div class="form-group ">
                                <label>学历</label>
                                <input type="text" class="form-control" id="education" readonly>
                            </div>
                            <div class="form-group ">
                                <label>专业</label>
                                <input type="text" class="form-control" id="major" readonly>
                            </div>
                            <div class="form-group ">
                                <label>政治面貌</label>
                                <input type="text" class="form-control" id="politics" readonly>
                            </div>
                        </div>
                        <div class="fromrow row">
                            <div class="form-group ">
                                <label>教育经历</label>
                                <input type="text" class="form-control" id="edu_history_one" readonly>
                            </div>
                            <div class="form-group ">
                                <input type="text" class="form-control" id="edu_history_two" readonly>
                            </div>
                            <div class="form-group ">
                                <input type="text" class="form-control" id="edu_history_three" readonly>
                            </div>
                        </div>
                        <div class="fromrow row">
                            <div class="form-group ">
                                <label>紧急联系人</label>
                                <input type="text" class="form-control" id="sosname" readonly>
                            </div>
                            <div class="form-group ">
                                <label>紧急联系人电话</label>
                                <input type="text" class="form-control" id="sosmobile" readonly>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer" style="text-align: left;">
                    <form id="acceptForm">
                        <div class="form-group">
                            <label>请输入审核意见</label>
                            <textarea class="form-control" rows="3" id="content" name="content" maxlength="200"></textarea>
                        </div>
                    </form>
                </div>
            </div>
            <%--按钮部分--%>
            <div class="modal-footer butt-foot" >
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>--%>
                    <button type="button" class="btn btn-success" onclick="pass(1)">通过</button>
                    <button type="button" class="btn btn-danger" onclick="pass(2)">不通过</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
   <div class="row">
      <h1 class="col-md-12 ">入职资料审核</h1>
        </div>
          <div class="row">
            <div class="col-md-8">
               <form class="form-inline">
                   <div class="form-group">
                        <label for="param_name">姓名</label>
                           <input type="text" class="form-control" id="param_name" placeholder="请输入姓名">
                            </div>
                         <div class="form-group">
                         <label for="param_status">审核状态</label>
                         <select class="form-control" id="param_status">
                        <option value="">全部</option>
                        <option value="0">待审核</option>
                        <option value="1">已通过</option>
                        <option value="2">未通过</option>
                    </select>
                </div>
                <button type="button" class="btn btn-success" onclick="selectList()">查询</button>
            </form>
        </div>
        <%--<div class="col-md-4">
            <button class="btn btn-danger" type="button" onclick="deleteEmpl()">批量审核</button>
        </div>--%>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emplTable">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll" onchange="checkAllEmpl()"></th>
                    <th>序号</th>
                    <th>姓名</th>
                    <th>审核状态</th>
                    <th>资料填写时间</th>
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
        selectList(1);
    });
    function createTableDate(result){
        var list = result.data.list;
        var html = "";

        for (var i=0;i<list.length;i++){

            var bean = list[i];
            html += '<tr>';
            html += '    <td><input class="checkEmpl" type="checkbox" id='+bean.id+'></td>';
            html += '    <td>'+(i+1)+'</td>';
            html += '    <td>'+bean.name+'</td>';
            html += '    <td>'+formatStatus(bean.status)+'</td>';
            html += '    <td>'+bean.addTime+'</td>';
            html += '    <td>';
            if(bean.status == '0'){
                html += '    <button class="btn btn-primary btn-sm" type="button" onclick="addEmpl('+bean.infoId+','+bean.id+',1)">';
                html += '        <span class="glyphicon glyphicon-pencil">审核</span>';
                html += '        </button>';
            }else{
                html += '    <button class="btn btn-info btn-sm" type="button" onclick="addEmpl('+bean.infoId+','+bean.id+',2)">';
                html += '        <span class="glyphicon glyphicon-pencil">详情</span>';
                html += '        </button>';
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
        $.ajax({
            url:"${APP_PATH}/accept/list",
            data:{
                pageNum: pageNum,
                name: name,
                status: status
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
        $("#id").val("");
        $("#infoId").val("");
        $("#name").val("");
        $("#sex").val("");
        $("#age ").val("");
        $("#cardId").val("");
        $("#marry").val("");
        $("#healthy").val("");
        $("#mobile").val("");
        $("#nativee").val("");
        $("#address").val("");
        $("#education").val("");
        $("#major").val("");
        $("#politics").val("");
        $("#edu_history_one").val("");
        $("#edu_history_two").val("");
        $("#edu_history_three").val("");
        $("#sosname").val("");
        $("#sosmobile").val("");
        $("#content").val("");
        //重置表单校验组件
        $("#acceptForm").data('bootstrapValidator').destroy();
        $('#acceptForm').data('bootstrapValidator',null);

    })



    function formatStatus(status){
        if (status == '0'){
            return '待审核';
        }else if (status == '1'){
            return '审核通过';
        }else if (status == '2'){
            return '审核不通过';
        }
    }
    //审核 type:1-审核 2-查看
    function addEmpl(infoId,id,type) {
        $("#id").val(id);
        initAccept(infoId,id);
        $('#myModal').modal('show');
        if (type == 2){
            //仅能查看
            $("#content").attr("readonly","readonly");
            $(".butt-foot").hide();
        }else{
            $("#content").removeAttr("readonly");
            $(".butt-foot").show();
        }
        //初始化表单校验
        $('#acceptForm').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                content : {
                    validators :{
                        notEmpty: {
                            message : '审核意见不能为空'
                        }
                    }
                }
            }
        });
    }
    //初始化审核详情
    function initAccept(infoId,id){
        $.ajax({
            url:"${APP_PATH}/accept/initAccept",
            data:{
                infoId:infoId,
                accId:id
            },
            type:"GET",
            success : function (result){
                if (result.data.info == null){
                    alert("没有数据");
                    return;
                }
                var acce = result.data.accept;
                if (acce!=null){
                    $("#content").val(acce.content);
                }
                var info = result.data.info;
                $("#infoId").val(infoId);
                $("#name").val(info.name);
                $("#sex").val(info.sex == '0' ? '男' :'女');
                $("#age").val(info.age);
                $("#cardId").val(info.cardId);
                $("#marry").val(info.marry== '1' ? '是' :'否');
                $("#healthy").val(info.healthy== '1' ? '是' :'否');
                $("#mobile").val(info.mobile);
                $("#nativee").val(info.nativee);
                $("#address").val(info.address);
                $("#education").val(info.education);
                $("#major").val(info.major);
                $("#politics").val(info.politics);
                $("#edu_history_one").val(info.eduHistoryOne);
                $("#edu_history_two").val(info.eduHistoryTwo);
                $("#edu_history_three").val(info.eduHistoryThree);
                $("#sosname").val(info.sosname);
                $("#sosmobile").val(info.sosmobile);
            }
        });
    }
    //审核
    function pass(status){
        var bootstrapValidator = $("#acceptForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()){
            var accept = {};
            //审核表主键
            accept.id = $("#id").val();
            //审核状态
            accept.status = status;
            //审核意见
            accept.content = $("#content").val();
            //入职信息表主键
            accept.infoId = $("#infoId").val();
            //当前用户
            accept.userId = localStorage.getItem("uid");
            $.ajax({
                url:"${APP_PATH}/accept/pass",
                data: JSON.stringify(accept),
                contentType : 'application/json',
                type: "POST",
                success : function (result) {
                    if (result.code == 200){
                        alert(result.msg);
                        $('#myModal').modal('hide');
                        selectList(1);
                    }
                }
            });
        }
    }
</script>
</body>
</html>
