<%--
  Created by IntelliJ IDEA.
  User: njustz
  Date: 2019/9/27
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Employee Lists</title>

    <!--引入jquery -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <!--引入样式 -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

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
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>DeptName</th>
                        <th>Operation</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.empGender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-pencil"></span> 编辑</button>
                                <button class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-remove"></span>删除</button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>

        <%--显示分页信息--%>
        <div class="row">
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总条${pageInfo.total}记录
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1 }" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_Num}</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${pageInfo.hasNextPage }">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1 }" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">最后一页</a></li>
                    </ul>
                </nav>
            </div>

        </div>

    </div>

</body>
</html>
