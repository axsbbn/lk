<%--
  Created by IntelliJ IDEA.
  User: 86149
  Date: 2021/10/20
  Time: 9:34
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
    <title>员工管理</title>
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
                    <%--部门--%>
                    <div class="form-group">
                        <label for="departmen" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-10">
                            <input type="text" name="mobile" class="form-control" id="departmen" placeholder="请输入部门">
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
                    <label for="param_departmen">部门</label>
                    <input type="text" class="form-control" id="param_departmen" placeholder="请输入部门">
                </div>
                <button type="button" class="btn btn-success" onclick="selectUserInfo(1)">查询</button>
            </form>
        </div>
        <div class="col-md-4">
            <button type="button" class="btn btn-primary" onclick="addUser()">新增</button>
            <button type="button" class="btn btn-danger" onclick="deleteUser()">删除</button>
        </div>
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
                <th>性别</th>
                <th>介绍</th>
                <th>部门</th>
                <th>入职日期</th>
                <th>出生日期</th>
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




</body>
</html>
