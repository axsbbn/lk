 <%--
  Created by IntelliJ IDEA.
  User: 86149
  Date: 2021/11/19
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/mui/css/mui.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/mui/js/mui.picker.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/mui/css/mui.picker.min.css">
    <title>员工信息采集</title>
    <style type="text/css">
        .radio_inline{
            display: inline-block;
            width: 65%;
        }
        .radio_inline label{

            width: 20%;
            padding-left: 40px;
            padding-right: 40px;
        }
        .radio_inline input[type=radio]{
            width: 15%;
            right: auto;
        }
        input{
            text-align: right;
            padding-right: 30px !important;
        }
        input[type='radio']{
            text-align: left;
        }
        .mui-input-row label{
            color: #4278a5;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <header class="mui-bar mui-bar-nav">
        <h1 id="title" class="mui-title">员工信息采集</h1>
    </header>
    <div class="mui-content">
        <form class="mui-input-group">
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>姓名</label>
                <input type="text" class="mui-input-clear" id="name" placeholder="请输入用户名">
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>性别</label>
                <span class="radio_inline mui-radio">
                    <input name="sex" type="radio" id="radio_man" checked value="0">
                    <label for="radio_man">男</label>
                    <input name="sex" type="radio" id="radio_woman" value="1">
                    <label for="radio_woman">女</label>
                </span>
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>身份证件号</label>
                <input type="text" class="mui-input-clear" id="cardId" placeholder="请输入身份证件号">
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>是否已婚</label>
                <span class="radio_inline mui-radio">
                    <input name="marry" type="radio"  id="marry" checked value="0">
                    <label for="marry">否</label>
                    <input name="marry" type="radio"  id="noMarry" value="1">
                    <label for="noMarry">是</label>
                </span>
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>籍贯</label>
                <input type="text" class="mui-input-clear" id="nativee" placeholder="请输入籍贯">
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>现住址</label>
                <input type="text" class="mui-input-clear" id="address" placeholder="请输入现住址">
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>是否健康</label>
                <span class="radio_inline mui-radio">
                    <input name="healthy" type="radio"  id="health" checked value="0">
                    <label for="radio_man">否</label>
                    <input name="healthy" type="radio"  id="nohealth" value="1">
                    <label for="radio_woman">是</label>
                </span>
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>手机号</label>
                <input type="number" class="mui-input-clear" id="mobile" placeholder="请输入手机号">
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>年龄</label>
                <input type="number" class="mui-input-clear" id="age" placeholder="请输入年龄" max="100" min="1">
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>学历</label>
                <input type="text" class="mui-input-clear" placeholder="请选择" onclick="selectEdu()" id="education" readonly="readonly">
            </div>
            <div class="mui-input-row">
                <label><span style="color:red;">*</span>专业</label>
                <input type="text" class="mui-input-clear" id="major" placeholder="请输入专业">
            </div>
            <div class="mui-input-row">
                <label>政治面貌</label>
                <input type="text" class="mui-input-clear" placeholder="请选择" onclick="selectPolitics()" id="politics" readonly="readonly">
            </div>
            <div class="mui-input-row">
                <label>教育经历</label>
            </div>
            <div class="mui-input-row">
                <input type="text" class="mui-input-clear" id="edu_history_one" placeholder="教育经历1">
            </div>
            <div class="mui-input-row">
                <input type="text" class="mui-input-clear" id="edu_history_two" placeholder="教育经历2">
            </div>
            <div class="mui-input-row">
                <input type="text" class="mui-input-clear" id="edu_history_three" placeholder="教育经历3">
            </div>
            <div class="mui-input-row">
                <label>紧急联系人姓名</label>
                <input type="text" class="mui-input-clear" placeholder="请填写紧急联系人电话" id="sosname" >
            </div>
            <div class="mui-input-row">
                <label>紧急联系人电话</label>
                <input type="text" class="mui-input-clear" placeholder="请填写紧急联系人电话" id="sosmobile" >
            </div>
            <div class="mui-button-row">
                <button type="button" class="mui-btn mui-btn-primary" onclick="saveInfo()">确认</button>
                <button type="button" class="mui-btn mui-btn-danger" >取消</button>
            </div>

        </form>
    </div>
</body>
<script type="text/javascript">
    mui.init();
    //学历选择器
    function selectEdu() {
        var picker = new mui.PopPicker();
        picker.setData([{value:'1',text:'专科'},{value:'2',text:'本科'},{value:'3',text:'研究生'}]);
        picker.show(function (selectItems) {
            //console.log(selectItems[0].text);//智子
            //console.log(selectItems[0].value);//zz
            $("#education").val(selectItems[0].text);
        })
    }
    //政治面膜选择器
    function selectPolitics() {
        var picker = new mui.PopPicker();
        picker.setData([{value:'1',text:'团员'},{value:'2',text:'党员'},{value:'3',text:'群众'}]);
        picker.show(function (selectItems) {
            $("#politics").val(selectItems[0].text);
        })
    }
    //保存信息
    function saveInfo(){
        if (checkData()){
            var user = makeBean();
            $.ajax({
                url:"${APP_PATH}/employeeinfo/addinfo",
                data: JSON.stringify(user),
                contentType : 'application/json',
                type: "POST",
                success : function (result) {
                    if (result.code == 200){
                        mui.alert("您的资料已经提交，HRz会尽快审核，请关注网站消息！")
                    }
                }
            });
        }

    }
    //保存前校验
    function checkData(){
        if($("#name").val() == ''  || $("#name").val() == null){
            mui.alert("姓名不能为空");
            return false;
        }else if($("#name").val() == ''  || $("#name").val() == null){
            mui.alert("姓名不能为空");
            return false;
        }

        if($("#radio_man").val() == ''  || $("#radio_man").val() == null){
            mui.alert("性别不能为空");
            return false;
        }else if($("#radio_woman").val() == ''  || $("#radio_woman").val() == null){
            mui.alert("性别不能为空");
            return false;
        }

        if($("#cardId").val() == ''  || $("#cardId").val() == null) {
            mui.alert("身份证号码不能为空");
            return false;
        }

        if($("#marry").val() == ''  || $("#marry").val() == null) {
            mui.alert("是否已婚不能为空");
            return false;
        }else if($("#noMarry").val() == ''  || $("#noMarry").val() == null) {
            mui.alert("是否已婚不能为空");
            return false;
        }

        if($("#nativee").val() == ''  || $("#nativee").val() == null) {
            mui.alert("籍贯不能为空");
            return false;
        }

        if($("#address").val() == ''  || $("#address").val() == null) {
            mui.alert("现住址不能为空");
            return false;
        }

        if($("#health").val() == ''  || $("#health").val() == null) {
            mui.alert("是否健康不能为空");
            return false;
        }else if($("#nohealth").val() == ''  || $("#nohealth").val() == null) {
            mui.alert("是否健康不能为空");
            return false;
        }

        if($("#mobile").val() == ''  || $("#mobile").val() == null) {
            mui.alert("手机号不能为空");
            return false;
        }

        if($("#age").val() == ''  || $("#age").val() == null) {
            mui.alert("年龄不能为空");
            return false;
        }

        if($("#education").val() == ''  || $("#education").val() == null) {
            mui.alert("学历不能为空");
            return false;
        }

        if($("#major").val() == ''  || $("#major").val() == null) {
            mui.alert("专业不能为空");
            return false;
        }

        if($("#politics").val() == ''  || $("#politics").val() == null) {
            mui.alert("政治面貌不能为空");
            return false;
        }

        /*if($("#edu_history_one").val() == ''  || $("#edu_history_one").val() == null) {
            mui.alert("教育经历不能为空");
            return false;
        }else if($("#edu_history_two").val() == ''  || $("#edu_history_two").val() == null) {
            mui.alert("教育经历不能为空");
            return false;
        }else if($("#edu_history_three").val() == ''  || $("#edu_history_three").val() == null) {
            mui.alert("教育经历不能为空");
            return false;
        }
        if($("#sosname").val() == ''  || $("#sosname").val() == null) {
            mui.alert("紧急联系人不能为空");
            return false;
        }else if($("#sosmobile").val() == ''  || $("#sosmobile").val() == null) {
            mui.alert("紧急联系人不能为空");
            return false;
        }*/


        return true;
    }
    //封装参数
    function makeBean(){
        var user = {};
        user.name = $("#name").val();
        user.sex = $('input[name="sex"]:checked').val();
        user.cardId = $("#cardId").val();
        user.marry = $('input[name="marry"]:checked').val();
        user.nativee = $("#nativee").val();
        user.address = $("#address").val();
        user.healthy = $('input[name="healthy"]:checked').val();
        user.mobile = $("#mobile").val();
        user.age = $("#age").val();
        user.education= $("#education").val();
        user.major= $("#major").val();
        user.politics= $("#politics").val();
        user.eduHistoryOne= $("#edu_history_one").val();
        user.eduHistoryTwo= $("#edu_history_two").val();
        user.eduHistoryThree= $("#edu_history_three").val();
        user.sosname = $("#sosname").val();
        user.sosmobile = $("#sosmobile").val();
        return user;
    }

</script>
</html>
