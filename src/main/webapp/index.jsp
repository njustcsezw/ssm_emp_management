<%--
  Created by IntelliJ IDEA.
  User: njustz
  Date: 2019/9/23
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<%--<jsp:forward page="/emps"></jsp:forward>--%>

<html>
<head>
    <meta charset="utf-8">
    <title>Title</title>

    <!--引入jquery -->
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <!--引入样式 -->
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>


    <!-- Modal添加员工信息 -->
    <div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Add Employee</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                <span class="help-block" id="empName_add_span"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="empEmail_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="empEmail_add_input" placeholder="email@gmail.com">
                                <span class="help-block" id="empEmail_add_span"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="gender1_add_input" value="M" checked="checked">男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="gender2_add_input" value="F">女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="deptId" id="dept_add_select"></select>
                            </div>
                        </div>

                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
                </div>

            </div>
        </div>
    </div>

    <%--显示详细信息界面--%>
    <div class="container">

        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>

        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
            <br>
            <br>
        </div>

        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>DeptName</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>

        <%--显示分页信息--%>
        <div class="row">
            <div class="col-md-6" id="page_info_area"></div>
            <div class="col-md-6" id="page_nav_area"></div>
        </div>

    </div>

    <script type="text/javascript">

        /*直接去发送ajax请求，要到分页数据从，首页数据*/
        $(function () {
            toPage(1);
        });
        
        function toPage(pn) {
            $.ajax({
                url:"${APP_PATH}/emp_lists",
                data:"pn="+pn,
                type:"GET",
                success:function (result){
                    //console.log(result);
                    //1.解析并显示员工数据
                    buildEmpsTable(result);
                    //2.解析并显示分页信息
                    buildPageInfo(result);
                    //3.解析显示分页条数据
                    buildPageNav(result);

                }
            })
        }

        /*//显示员工详细信息*/
        function buildEmpsTable(result) {
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;

            $.each(emps, function (index, item) {
                //alert(item.empName);
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var empGenderTd = $("<td></td>").append(item.empGender=='M'?'男':'女');
                var empEmailTd = $("<td></td>").append(item.email);
                var empDeptNameTd = $("<td></td>").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(empIdTd).append(empNameTd).append(empGenderTd)
                    .append(empEmailTd).append(empDeptNameTd)
                    .append(btnTd).appendTo("#emps_table tbody");
            })
        }

        //显示分页的详细信息
        function buildPageInfo(result) {
            $("#page_info_area").empty();

            var page = result.extend.pageInfo;
            var nav = $("<nav></nav>");
            var ul = $("<ul></ul>").addClass("pagination");
            var li = $("<li></li>").append("当前"+page.pageNum + "页,总" + page.pages + "页,总" + page.total + "条记录");
            //page_info_area
            ul.append(li);
            nav.append(ul);
            nav.appendTo("#page_info_area");
        }

        //创建分页导航栏
        function buildPageNav(result) {

            $("#page_nav_area").empty();
            //page_nav_area
            var page = result.extend.pageInfo;
            var nav = $("<nav></nav>");
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

            if(page.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                firstPageLi.click(function(){
                    toPage(1);
                });
                prePageLi.click(function(){
                    toPage(page.pageNum-1);
                });
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

            if(page.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    toPage(page.pageNum+1);
                });
                lastPageLi.click(function(){
                    toPage(page.pages);
                });
            }

            ul.append(firstPageLi).append(prePageLi);
            $.each(page.navigatepageNums, function(index, item){
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if(page.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    toPage(item);
                });
                ul.append(numLi);
            })

            ul.append(nextPageLi).append(lastPageLi);
            nav.append(ul);
            nav.appendTo("#page_nav_area");
        }

        function resetForm(ele){
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        /*点击添加按钮弹出模态框*/
        $("#emp_add_modal_btn").click(function () {
            //表单重置,包括数据及样式
            resetForm("#emp_add_modal form");
           /* $("#emp_add_modal form")[0].reset();
            showValidateMsg("#empName_add_input", "", null);
            showValidateMsg("#empEmail_add_input", "", null);*/
            //发送Ajax请求，显示部门下拉列表
            getDepts();
            /*弹出模态框*/
            $("#emp_add_modal").modal({
                backdrop:false
            })

        })

        /*查出所有部门详细信息*/
        function getDepts() {
            $("#dept_add_select").empty();
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    //console.log(result);
                    $.each(result.extend.depts, function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo("#dept_add_select");
                    })
                    //$("#dept_add_select")
                }
            })
        }

        /*对提交给服务器的表单数据进行校验，姓名与邮箱*/
        function validateAddForm(){
            var empName =  $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!regName.test(empName)){
                //alert("The user's name must contain 3-16 letters or 2-5 Chinese characters at least~");
                showValidateMsg("#empName_add_input", "error", "The user's name must contain 3-16 letters or 2-5 Chinese characters at least~");
                return false;
            }else {
                showValidateMsg("#empName_add_input", "success", "");
            }

            //alert(regName.test(empName));
            var empEmail = $("#empEmail_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(empEmail)){
                //alert("The user's email is illegal ~");
                showValidateMsg("#empEmail_add_input", "error", "The user's email is illegal ~");
                return false;
            }else {
                showValidateMsg("#empEmail_add_input", "success", "");
            }
            return true;
        }

        function showValidateMsg(ele, status, msg){
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next("span").text("");
            if("success" == status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }
            if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }

        }

        /*校验员工名是否合法*/
        $("#empName_add_input").change(function () {
            var empName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkName",
                data:"empName="+empName,
                type:"GET",
                success:function (result) {
                    if(result.code == 100){
                        showValidateMsg("#empName_add_input", "success", "The user's name is OK~");
                        $("#emp_save_btn").attr("ajax-va", "success");
                    }else {
                        showValidateMsg("#empName_add_input", "error", result.extend.va_name);
                        $("#emp_save_btn").attr("ajax-va", "error");
                    }
                }
            })
        })

        /*保存员工信息emp_save_btn*/
        $("#emp_save_btn").click(function () {

            //先进行校验
            //校验输入是否合法
            if(!validateAddForm()){
                return false;
            }
            //校验用户名是否重复
            if($(this).attr("ajax-va") == "error"){
                showValidateMsg("#empName_add_input", "error", "The user's name is repeated~");
                return false;
            }

            //将模态框中信息提交给服务器并保存
            //序列化展示 alert($("#emp_add_modal form").serialize());
            $.ajax({
                url:"${APP_PATH}/emp",
                data:$("#emp_add_modal form").serialize(),
                type:"POST",
                success:function (result) {
                    alert(result.msg);
                    //1.close modal
                    $("#emp_add_modal").modal('hide');
                    //2.jump to last page and display
                    toPage(9999);
                }
            })
        })

    </script>

</body>
</html>
