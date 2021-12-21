<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2021/10/19
  Time: 15:00
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
    <title>企业员工管理系统</title>
</head>
<body style="background-image: url('${APP_PATH}/static/img/tupian.jpeg');background-size: cover;">

<div class="container">
    <div class="row" style="margin-top:10%;">
        <div class="col-md-5"><h1 style="font-size: 45px;margin-top: 18%;color: #337ab7;">企业员工管理系统</h1></div>
        <div class="col-md-2"></div>
        <div class="col-md-5" style="border: 1px solid #DCDCDC;border-radius: 10px;padding: 20px;box-shadow:0px 0px 10px #000;padding-top: 50px;">
            <form class="form-horizontal" id="userForm">
                <%--用户名--%>
                <div class="form-group">
                    <label for="userName_input" class="col-sm-2 control-label">账号</label>
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
                <div class="form-group" style="text-align: center;">
                    <button type="button" class="btn btn-primary" onclick="login()">登录</button>
                </div>
                    <div class="form-group" style="text-align: center;">
                        <button type="button" class="btn btn-primary" onclick="register()">注册</button>
                    </div>
            </form>
        </div>
        <div class="col-md-4"></div>
    </div>
</div>
</body>
 <script type="text/javascript">
     //写jq代码
     $(function () {

     });
     function login() {
         if ($("#userName_input").val() == null || $("#userName_input").val() == ''){
             alert("用户名不能是空");
             return;
         }else if($("#password_input").val() == null || $("#password_input").val() == ''){
             alert("密码不能是空");
             return;
         }
         var user = {};
         //用户名
         user.userName = $("#userName_input").val();
         //密码
         user.password = $("#password_input").val();
         $.ajax({
             url:"${APP_PATH}/user/login",
             data: JSON.stringify(user),
             contentType : 'application/json',
             type: "POST",
             success : function (result) {
                 if (result.code == 200){
                    localStorage.setItem("uid",result.data.userInfo.id);
                     localStorage.setItem("uname",result.data.userInfo.userName);
                     window.location.href="index_menu.jsp";
                 }else{
                     alert(result.msg);
                 }
             }
         });
     }
     function register() {
         window.location.href="register.jsp";
     }
 </script>
</html>
