<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2021/10/14
  Time: 9:50
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
    <title>用户列表</title>
</head>
<body>
    <div class="container">
        <!-- 标题部分 -->
        <div class="row">
            <h1 class="col-md-12">用户列表</h1>
        </div>
        <!-- 功能按钮部分 -->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
        <!-- 数据表格部分 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>主键</th>
                        <th>姓名</th>
                        <th>密码</th>
                        <th>电话</th>
                        <th>性别</th>
                        <th>删除标志</th>
                        <th>插入时间</th>
                        <th>操作</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>张三</td>
                        <td>1234</td>
                        <td>123456787</td>
                        <td>男</td>
                        <td>1</td>
                        <td>2021-10-14</td>
                        <td>
                            <button type="button" class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                            </button>
                            <button type="button" class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>李四</td>
                        <td>1234</td>
                        <td>123456787</td>
                        <td>男</td>
                        <td>1</td>
                        <td>2021-10-14</td>
                        <td>
                            <button type="button" class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                            </button>
                            <button type="button" class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- 分页导航栏部分 -->
        <div class="row">
            <div class = "col-md-6">当前页码？</div>
            <div class = "col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li>
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li>
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
