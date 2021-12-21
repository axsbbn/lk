<%--
  Created by IntelliJ IDEA.
  User: 86149
  Date: 2021/11/18
  Time: 16:24
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
    <title>企业员工管理平台</title>
</head>
<body style="background-image: url('${APP_PATH}/static/img/tupian.jpeg');background-size: cover;">
<div class="container">
    <h1 align="center" style="margin-top: 10%;color: white">企业员工管理平台</h1>
    <div class="row" style="margin-top:30px;">
        <div class="col-md-4"></div>
        <div class="col-md-4" style="border: 1px solid #DCDCDC;border-radius: 10px;padding: 20px;box-shadow:0px 0px 10px #000;">
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
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">手机号</label>
                        <div class="col-sm-10">
                            <input type="text" name="phone" class="form-control" id="phone" placeholder="请输入手机号">
                        </div>
                    </div>
                    <div class="form-group" style="text-align: center;">
                        <button type="button" class="btn btn-primary" onclick="register()">注册</button>
                    </div>
        </form>
    </div>
    <div class="col-md-4"></div>
</div>
</div>
<script type="text/javascript">
    $(function (){
        //这里面就可以写页面加载完后执行的jq方法了
        //初始化表单校验
        $('#userForm').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                userName:{
                    validators:{
                        notEmpty:{
                            message:"用户名不能为空"
                        }
                    }
                },
                password:{
                    validators:{
                        notEmpty:{
                            message:"密码不能为空"
                        }
                    }
                },
                sex:{
                    validators:{
                        notEmpty:{
                            message:"性别不能为空"
                        }
                    }
                },
                phone:{
                    validators:{
                        notEmpty:{
                            message:"电话不能为空"
                        }
                    }
                }
            }
        });
    });
    function register() {
        var bootstrapValidator = $("#userForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()){
            var user = makeBean();
            //用户名
            user.userName = $('#userName_input').val();
            //密码
            user.password = $('#password_input').val();
            //电话号
            user.mobile = $('#phone').val();
            //性别
            user.sex = $('input[name="sex"]:checked').val();
            $.ajax({
                //请求地址
                url:"${APP_PATH}/user/register",
                //请求参数
                data:
                //JSON.stringify---js对象转成json格式
                    JSON.stringify(user),

                //当你的参数格式是json时,需要加以下代码,否则报错
                contentType : 'application/json',
                //请求类型
                type:"POST",
                //回调函数
                success : function (result){
                    console.log(result);
                    if (result.code == 200){
                        alert(result.msg);
                        //注册成功，跳转到登录界面
                        setTimeout(function(){
                            window.location.href="index.jsp";
                        }, 1500);
                    }else{
                        //失败
                        alert(result.msg);
                    }
                }
            });
        }
    }
    //封装user对象
    function makeBean(){
        var user={};
        //获取输入值
        //隐藏id
        if( $('#userid').val() && $('#userid').val() != '' && $('#userid').val() != undefined){
            user.userId = $('#userid').val();
        }
        //用户名
        user.userName = $('#userName_input').val();
        //密码
        user.password = $('#password_input').val();
        //性别,获取单选框被选中的值
        user.sex = $('input[name="sex"]:checked').val()==1 ? "男" : "女";
        //电话号码
        user.mobile = $('#mobile_input').val();
        //删除标志
        user.isDelete = '0';
        return user;
    }
</script>
</body>
</html>
