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
                <button class="btn btn-primary">新增</button>
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
                //alert(item.emp  Name);
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
            //$("#page_info_area").append("当前"+page.pageNum + "页,总" + page.pages + "页,总" + page.total + "条记录");
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

    </script>

</body>
</html>
