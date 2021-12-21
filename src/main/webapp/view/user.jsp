<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2021/10/14
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%--防止乱码--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入c标签库--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>用户列表</title>
</head>
<body>
<%--用户信息模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <%--标题部分--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户信息</h4>
            </div>
            <%--内容部分--%>
            <div class="modal-body">
                <form class="form-horizontal" id="userForm">
                    <input type="hidden" id="userid">
                    <%--用户名--%>
                    <div class="form-group">
                        <label for="userName_input" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" name="userName" class="form-control" id="userName_input" placeholder="请输入用户名">
                        </div>
                    </div>
                    <%--密码--%>
                    <div class="form-group">
                        <label for="password_input" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="password" class="form-control" id="password_input" placeholder="请输入密码">
                        </div>
                    </div>
                    <%--性别--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="inlineRadio1" value="1"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="inlineRadio2" value="2"> 女
                            </label>
                        </div>
                    </div>
                    <%--电话号--%>
                    <div class="form-group">
                        <label for="mobile_input" class="col-sm-2 control-label">电话号</label>
                        <div class="col-sm-10">
                            <input type="text" name="mobile" class="form-control" id="mobile_input" placeholder="请输入电话号">
                        </div>
                    </div>

                </form>
            </div>
            <%--按钮部分--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveUserInfo()">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- 标题部分 -->
    <div class="row">
        <h1 class="col-md-12">用户列表</h1>
    </div>
    <!-- 功能按钮部分 -->
    <div class="row">
        <div class="col-md-8">
            <form class="form-inline">
                <div class="form-group">
                    <label for="param_name">用户名</label>
                    <input type="text" class="form-control" id="param_name" placeholder="请输入用户名">
                </div>
                <div class="form-group">
                    <label for="param_mobile">电话</label>
                    <input type="text" class="form-control" id="param_mobile" placeholder="请输入电话号">
                </div>
                <button type="button" class="btn btn-success" onclick="selectUserInfo(1)">查询</button>
            </form>
        </div>
        <div class="col-md-4">
            <button type="button" class="btn btn-primary" onclick="addUser()">新增</button>
            <button type="button" class="btn btn-danger" onclick="deleteUser()">删除</button>
        </div>
    </div>
    <!-- 数据表格部分 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="userTable">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll" onchange="checkAllUser()"></th>
                    <th>主键</th>
                    <th>姓名</th>
                    <th>密码</th>
                    <th>电话</th>
                    <th>性别</th>
                    <th>注册时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <%-- 这个地方放每个用户的信息 --%>
                </tbody>
                <%-- 遍历java对象list,把每个对象起个别名叫user --%>

            </table>
        </div>
    </div>
    <!-- 分页导航栏部分 -->
    <div class="row">
        <div class = "col-md-6" id="nav_info"></div>
        <div class = "col-md-6" id="nav_tab">
        </div>
    </div>
</div>
<script type="text/javascript">
    //写jq代码
    $(function () {
        //这里面就可以写页面加载完之后执行的jq方法了
        selectUserInfo(1);
    });
    //构建table页面数据
    function buileTableDate(result){
        //1.取出表格数据
        var userList = result.data.list;
        var html = "";
        //循环取用户信息
        for(var i=0;i<userList.length;i++){
            //从数组中取元素
            var user = userList[i];
            html +='<tr>';
            html +='    <td><input class="checkUser" type="checkbox" id="'+user.id+'"></td>';
            html +='    <td>'+user.id+'</td>';
            html +='    <td>'+user.userName+'</td>';
            html +='    <td>******</td>';
            html +='    <td>'+(user.mobile == null ? "" : user.mobile)+'</td>';
            html +='    <td>'+(user.sex == 1 ? "男" : "女")+'</td>';
            html +='    <td>'+user.createTime+'</td>';
            html +='    <td>';
            html +='        <button type="button" class="btn btn-primary btn-sm" onclick="addUser('+user.id+')">';
            html +='            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑';
            html +='        </button>';
            html +='        <button type="button" class="btn btn-danger btn-sm" onclick="deleteUserById('+user.id+','+result.data.pageNum+')">';
            html +='            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除';
            html +='        </button> ';
            html +='    </td>';
            html +='</tr>';
        }
        $("#userTable tbody").html(html);
    }
    //构建分页信息
    function buileNavDate(result) {
        var html = "当前页码"+result.data.pageNum+",总共"+result.data.pages+"页,总共"+result.data.total+"条数据";
        $("#nav_info").html(html);
    }
    //显示分页导航栏
    function buileNav(result) {
        var pageArray = result.data.navigatepageNums;
        var html = "";
        html+='<nav aria-label="Page navigation">';
        html+='    <ul class="pagination">';
        html+='        <li onclick="selectUserInfo(1)"><a href="#">首页</a></li>';
        //如果当前页有上一页，显示上翻页
        if (result.data.hasPreviousPage){
            html+='        <li onclick="selectUserInfo('+result.data.prePage+')">';
            html+='            <a href="#" aria-label="Previous">';
            html+='                <span aria-hidden="true">&laquo;</span>';
            html+='           </a>';
            html+='       </li>';
        }

        //循环页码动态展示
        for(var i=0;i<=pageArray.length-1;i++){
            //判断当前页面高亮显示
            if (result.data.pageNum == pageArray[i]){
                html+='       <li class="active"><a href="#">'+pageArray[i]+'</a></li>';
            }else{
                html+='       <li onclick="selectUserInfo('+pageArray[i]+')"><a href="#">'+pageArray[i]+'</a></li>';
            }
        }
        //如果当前页有下一页，显示下翻页
        if(result.data.hasNextPage){
            html+='       <li onclick="selectUserInfo('+result.data.nextPage+')">';
            html+='           <a href="#" aria-label="Next">';
            html+='               <span aria-hidden="true">&raquo;</span>';
            html+='           </a>';
            html+='       </li>';
        }
        html+='       <li onclick="selectUserInfo('+result.data.pages+')"><a href="#">尾页</a></li>';
        html+='   </ul>';
        html+='</nav>';
        $("#nav_tab").html(html);
    }
    //查询用户信息
    function selectUserInfo(pageNum) {
        //获取参数值
        var name = $("#param_name").val();
        var mobile = $("#param_mobile").val();
        $.ajax({
            url:"${APP_PATH}/user/selectUserListForJson",
            data:{
                pageNum : pageNum,
                userName : name,
                mobile : mobile
            },
            type: "GET",
            success : function (result) {
                console.log(result);
                //构建table页面数据
                buileTableDate(result);
                //显示分页信息
                buileNavDate(result);
                //显示分页导航栏信息
                buileNav(result);
            }
        });
    }
    //新增用户
    function addUser(id) {
        if( id!=null && id!='' && id !=undefined ){
            //根据id查询用户信息，并且展示在模态框上
            initUserInfo(id);
        }
        $('#myModal').modal('show');
        //初始化表单校验
        $('#userForm').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                userName : {
                    validators :{
                        notEmpty: {
                            message : '用户姓名不能为空'
                        },
                        stringLength: {
                            min : 2,
                            max : 10,
                            message: '用户名长度在2-10之间'
                        }
                    }
                },
                password : {
                    validators :{
                        notEmpty: {
                            message : '密码不能为空'
                        },
                        stringLength: {
                            min : 8,
                            max : 20,
                            message: '密码长度在8-20之间'
                        }
                    }
                },
                sex : {
                    validators :{
                        notEmpty: {
                            message : '性别不能为空'
                        }
                    }
                },
                mobile : {
                    validators :{
                        notEmpty: {
                            message : '电话号码不能为空'
                        },
                        regexp :{
                            regexp:/^1(?:3\d|4[4-9]|5[0-35-9]|6[67]|7[013-8]|8\d|9\d)\d{8}$/,
                            message:'请输入正确的电话号码'
                        }
                    }
                }
            }
        });
    }
    //保存用户信息
    function saveUserInfo() {
        var bootstrapValidator = $("#userForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()){
            var user = makeBean();
            $.ajax({
                url:"${APP_PATH}/user/addUser",
                data: JSON.stringify(user),
                contentType : 'application/json',
                type: "POST",
                success : function (result) {
                    if (result.code == 200){
                        alert(result.msg);
                        $('#myModal').modal('hide');
                        selectUserInfo(1);
                    }
                }
            });
        }
    }
    //封装user对象
    function makeBean() {
        var user={};
        //id
        if ($("#userid").val() != null && $("#userid").val() != '' && $("#userid").val() != undefined){
            user.id = $("#userid").val();
        }
        //用户名
        user.userName = $("#userName_input").val();
        //密码
        user.password = $("#password_input").val();
        //性别
        user.sex = $('input[name="sex"]:checked').val();
        //电话号
        user.mobile = $("#mobile_input").val();
        //删除标志
        user.isDelete = '0';
        return user;
    }

    //关闭模态框触发的事件
    $("#myModal").on('hidden.bs.modal',function () {
        //重置输入框的值
        $("#userName_input").val("");
        $("#password_input").val("");
        $("#inlineRadio1").prop("checked",false);
        $("#inlineRadio2").prop("checked",false);
        $("#mobile_input").val("");
        $("#userid").val("");
        //重置表单校验组件
        $("#userForm").data('bootstrapValidator').destroy();
        $('#userForm').data('bootstrapValidator',null);
    })
    //初始化用户信息
    function initUserInfo(id) {
        $.ajax({
            url:"${APP_PATH}/user/selectUserListForJson",
            data:{
                userId : id
            },
            type: "GET",
            success : function (result) {
                var user = result.data.list[0];
                //姓名
                $("#userName_input").val(user.userName);
                //密码
                $("#password_input").val(user.password);
                //性别
                if (user.sex == 1){
                    $("#inlineRadio1").prop("checked",true);
                }else if (user.sex == 2){
                    $("#inlineRadio2").prop("checked",true);
                }
                //电话
                $("#mobile_input").val(user.mobile);
                //id
                $("#userid").val(id);
            }
        });
    }
    //根据主键删除用户
    function deleteUserById(id,pageNum) {
        $.ajax({
            url:"${APP_PATH}/user/deleteUser",
            data:{
                id : id
            },
            type: "GET",
            success : function (result) {
                if(result.code == 200){
                    alert(result.msg);
                    selectUserInfo(pageNum);
                }
            }
        });
    }
    function checkAllUser() {
        //判断了全选框的状态，如果已经选中，把所有checkbox的选中状态设置为已经选中
        //如果未选中，把所有checkbox的选中状态设置为未选中
        if($("#checkAll").prop("checked")){
            $(".checkUser").prop("checked",true);
        }else {
            $(".checkUser").prop("checked",false);
        }
    }

    function deleteUser() {
        var ids = [];
        //处理参数
        var checkBoxUser = $(".checkUser:checked");
        checkBoxUser.each(function () {
            ids.push($(this).attr("id"));
        });

        $.ajax({
            url:"${APP_PATH}/user/deleteUserPl",
            data:{
                ids : ids.toString()
            },
            type: "GET",
            success : function (result) {
                if(result.code == 200){
                    alert(result.msg);
                    selectUserInfo(1);
                }
            }
        });
    }
</script>
</body>
</html>