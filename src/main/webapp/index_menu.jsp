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
    <title>员工管理系统</title>
    <style type="text/css">
        .top{
            height: 40px;
            background-color: #333;
            color: #fff;
            text-align: right;
            line-height: 40px;
            font-size: 17px;
            padding-right: 10px;
        }
        .top a{
            margin-left: 10px;
        }
        .menu{
            padding: 0;
            text-align: center;
            background-color: #333;
            font-size: 17px;
            height: 100%;
        }
        .menu a{
            color: #fff;
        }
        .nav>li>a:focus, .nav>li>a:hover {
            color: #333;
        }
        .menu .nav li.checked a{
            color: #333;
        }
        .menu .nav li.checked{
            background-color: #eee;
            color: #333;
        }
    </style>
</head>
<body>
<div class="container-fluid" style="padding: 0;">
    <%--    左侧菜单--%>
    <div class="col-md-2 menu" style="padding: 0;">
        <ul class="nav nav-pills nav-stacked">
            <li ><a href="hello.jsp" target="mainFrame">首页</a></li>
            <li ><a href="view/user.jsp" target="mainFrame">用户管理</a></li>
            <li ><a href="view/employee.jsp" target="mainFrame">员工管理</a></li>
            <li ><a href="view/accept.jsp" target="mainFrame">入职资料审核</a></li>
            <li ><a href="view/contractMana.jsp" target="mainFrame">入职合同签订</a></li>
        </ul>
    </div>
    <%--右侧内容--%>
    <div class="col-md-10" style="padding: 0;">
        <div class="top">
            <span>admin</span>
            <a href="#" onclick="logout()">退出</a>
        </div>
        <iframe id="mainFrame" name="mainFrame" width="100%" height="100%" frameborder="0" src="hello.jsp"></iframe>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        //这里面就可以写页面加载完之后执行的jq方法了
        $(".menu .nav li").each(function () {
            $(this).click(function () {
                $(".menu .nav li").removeClass("checked");
                $(this).addClass("checked");
            })
        })
    });
    function logout() {
        localStorage.clear();
        window.location.href = "index.jsp";
    }
</script>
</html>
