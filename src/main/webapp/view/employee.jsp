<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2021/10/19
  Time: 15:35
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
    <title>员工列表</title>
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
<div class="modal fade" tabindex="-1" role="dialog" id="infoModal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <%--标题部分--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">详细资料</h4>
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
            </div>
        </div>
    </div>
</div>
<!-- 员工信息 -->
<div class="modal fade" tabindex="-1" role="dialog" id="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <%--标题部分--%>
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工信息</h4>
            </div>
            <%--内容部分--%>
            <div class="modal-body">
                <form class="form-horizontal" id="emplForm">
                    <%--                    隐藏表单域--%>
                    <input type="hidden" id="emplid">
                    <%--用户名--%>
                    <div class="form-group">
                        <label for="emplName_input" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" name="emplName" class="form-control" id="emplName_input" placeholder="请输入用户名">
                        </div>
                    </div>
                    <%--性别--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10" id="sexId">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sexId1" value="0"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sexId2" value="1"> 女
                            </label>
                        </div>
                    </div>

<%--                    部门--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-10" id="depId">
                            <label class="radio-inline">
                                <input type="radio" name="department" id="depId1" value="1">销售部
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="department" id="depId2" value="2">技术部
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="department" id="depId3" value="3">管理部
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="department" id="depId4" value="4">后勤部
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="department" id="depId5" value="5">人事部
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="product_input" class="col-sm-2 control-label">入职日期</label>
                        <div class="col-sm-10">
                            <input type="date" name="product" class="form-control" id="product_input" placeholder="请输入密码">
                        </div>
                    </div>
                </form>
            </div>
            <%--按钮部分--%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="saveEmplInfo()">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <h1 class="col-md-12 ">员工管理</h1>
    </div>
    <div class="row">
        <div class="col-md-8">
            <form class="form-inline">
                <div class="form-group">
                    <label for="param_name">用户名</label>
                    <input type="text" class="form-control" id="param_name" placeholder="请输入用户名">
                </div>
                <div class="form-group">
                    <label for="param_department">部门</label>
                    <select class="form-control" id="param_department">
                        <option id="depart" value="">查询全部</option>
                        <option id="depart1" value="1">销售部</option>
                        <option id="depart2" value="2">技术部</option>
                        <option id="depart3" value="3">管理部</option>
                        <option id="depart4" value="4">后勤部</option>
                        <option id="depart5" value="5">人事部</option>
                    </select>
                </div>
                <button type="button" class="btn btn-success" onclick="selectEmplInfo()">查询</button>
            </form>
        </div>
        <div class="col-md-4">
            <%--<button class="btn btn-primary" type="button" onclick="addEmpl()">新增</button>--%>
            <button class="btn btn-danger" type="button" onclick="deleteEmpl()">批量删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emplTable">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll" onchange="checkAllEmpl()"></th>
                    <th>No.</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>部门</th>
                    <th>入职日期</th>
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
        selectEmplInfo(1);
    });
    function createTableDate(result){
        var emplList = result.data.list;
        var html = "";

        for (var i=0;i<emplList.length;i++){

            var empl = emplList[i];
            html += '<tr>';
            html += '    <td><input class="checkEmpl" type="checkbox" id='+empl.emplId+'></td>';
            html += '    <td>'+(i+1)+'</td>';
            html += '    <td>'+empl.emplName+'</td>';
            html += '    <td>'+sexName(empl.sex)+'</td>';
            html += '    <td>'+departmentName(empl.department)+'</td>';
            html += '    <td>'+empl.productDate+'</td>';
            html += '    <td>';
            html += '        <button class="btn btn-info btn-sm" type="button" onclick="info('+empl.emplId+')">';
            html += '        <span class="glyphicon glyphicon-user">详细资料</span>';
            html += '        </button>';
            html += '    <button class="btn btn-primary btn-sm" type="button" onclick="addEmpl('+empl.emplId+')">';
            html += '        <span class="glyphicon glyphicon-pencil">编辑</span>';
            html += '        </button>';
            html += '        <button class="btn btn-danger btn-sm" type="button" onclick="deleteEmplById('+empl.emplId+','+result.data.pageNum+')">';
            html += '        <span class="glyphicon glyphicon-trash">删除</span>';
            html += '        </button>';
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

    function selectEmplInfo(pageNum){
        var name = $('#param_name').val();
        // var department = $('#param_department').prop("checked",true);
        var department = $('#param_department').val();
        $.ajax({
            url:"${APP_PATH}/empl/selectEplListForJson",
            data:{
                pageNum: pageNum,
                emplName: name,
                department: department
            },
            type:"GET",
            success : function (result){
                console.log(result);
                createTableDate(result);
                buileNavDate(result);
                buileNav(result);
            }
        });
    }

    function checkAllEmpl(){
        if ($('#checkAll').prop("checked")){
            $(".checkEmpl").prop("checked",true);
        }else {
            $(".checkEmpl").prop("checked",false);
        }
    }

    function addEmpl(id){
        if (id !=null && id !='' && id !=undefined){
            $.ajax({
                url:"${APP_PATH}/empl/selectEplListForJson",
                data:{
                    emplId:id
                },
                type:"GET",
                success : function (result){
                    console.log(result);
                    var empl = result.data.list[0];
                    $('#emplName_input').val(empl.emplName);
                    if (empl.sex==0){
                        $('#sexId1').prop("checked",true);
                    }else if(empl.sex==1){
                        $('#sexId2').prop("checked",true);
                    }
                    $('#content_input').val(empl.content);
                    if (empl.department==1){
                        $('#depId1').prop("checked",true);
                    }else if(empl.department==2){
                        $('#depId2').prop("checked",true);
                    }else if(empl.department==3){
                        $('#depId3').prop("checked",true);
                    }else if(empl.department==4){
                        $('#depId4').prop("checked",true);
                    }else if(empl.department==5){
                        $('#depId5').prop("checked",true);
                    }
                    $('#product_input').val(empl.productDate);
                    $('#birthday_input').val(empl.birthday);
                    $('#emplid').val(id);
                }
            });
        }
        $('#myModal').modal('show');
        $('#emplForm').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                emplName:{
                    validators:{
                        notEmpty:{
                            message:"用户名不能为空"
                        },
                        stringLength:{
                            min:2,
                            max:5,
                            message:"用户名长度在2-5之间"
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
                department:{
                    validators:{
                        notEmpty:{
                            message:"部门不能为空"
                        }
                    }
                },
                product:{
                    validators:{
                        notEmpty:{
                            message:"入职日期不能为空"
                        }
                    }
                }
            }
        });
    }

    $('#myModal').on('hidden.bs.modal',function (){
        $('#emplName_input').val("");

        $('#sexId1').prop("checked",false);
        $('#sexId2').prop("checked",false);
        $('#content_input').val("");

        $('#depId1').prop("checked",false);
        $('#depId2').prop("checked",false);
        $('#depId3').prop("checked",false);
        $('#depId4').prop("checked",false);
        $('#depId5').prop("checked",false);

        $('#product_input').val("");
        $('#birthday_input').val("");
        $('#emplid').val("");
        //重置表单校验
        $('#emplForm').data('bootstrapValidator').destroy();
        $('#emplForm').data('bootstrapValidator',null);
    });

    function saveEmplInfo(){
        var bootstrapValidator = $("#emplForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()){
            var empl = makeBean();
            $.ajax({
                url:"${APP_PATH}/empl/addEmpl",
                data: JSON.stringify(empl),
                contentType : 'application/json',
                type:"POST",
                success : function (result){
                    console.log(result);
                    if (result.code == 200){
                        alert(result.msg);
                        $('#myModal').modal('hide')
                        selectEmplInfo(1);
                    }
                }
            });
        }
    }

    function makeBean(){
        var empl={};

        if( $('#emplid').val() && $('#emplid').val() != '' && $('#emplid').val() != undefined){
            empl.emplId = $('#emplid').val();
        }

        empl.emplName = $('#emplName_input').val();

        empl.sex = $('input[name="sex"]:checked').val();
        empl.content = $('#content_input').val();
        empl.department = $('input[name="department"]:checked').val();
        // empl.department = $('#department_input').val();
        empl.productDate = $('#product_input').val();
        empl.birthday = $('#birthday_input').val();
        empl.isDelete = '0';
        return empl;
    }

    function deleteEmplById(id,pageNum){
        $.ajax({
            url:"${APP_PATH}/empl/deleteEmpl",
            data:{
                id:id
            },
            type:"POST",
            success : function (result){
                console.log(result);
                if (result.code == 200){
                    alert(result.msg);
                    selectEmplInfo(pageNum);
                }
            }
        });
    }
    //部门转换
    function departmentName(depId){
        if (depId == '1'){
            return '销售部';
        }else if(depId == '2'){
            return '技术部';
        }else if(depId == '3'){
            return '管理部';
        }else if(depId == '4'){
            return '后勤部';
        }else if(depId == '5'){
            return '人事部';
        }else{
            return '待分配';
        }
    }
    function sexName(sexId){
        if (sexId == '0'){
            return "男";
        }else if (sexId == '1'){
            return "女";
        }
    }
    function deleteEmpl(){
        var ids=[];
        var checkBoxEmpl=$('.checkEmpl:checked');
        checkBoxEmpl.each(function (){
            ids.push($(this).attr("id"));
        });
        $.ajax({
            url:"${APP_PATH}/empl/deleteEmplPl",
            data:{
                ids:ids.toString()
            },
            type:"GET",
            success : function (result){
                console.log(result);
                if (result.code==200){
                    alert(result.msg);
                    selectEmplInfo(1);
                }
            }
        });
    }
    function info(empId) {
        $('#infoModal').modal('show');
        $.ajax({
            url:"${APP_PATH}/accept/initAccept",
            data:{
                empId:empId
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
</script>
</body>
</html>
