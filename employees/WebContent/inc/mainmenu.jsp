<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<div class="jumbotron text-center container-fluid" style="margin-bottom:0">
  <h1>My Photoporio Page</h1>
  <p></p> 
</div>	
	<nav class="navbar navbar-expand-sm bg-primary navbar-dark container-fluid ">
  <ul class="navbar-nav">
    <li class="nav-item ">
      <a class="nav-link" href="<%=request.getContextPath() %>/index.jsp"><i class='fas fa-home'></i>홈으로</a>
    </li>
    <li class="nav-item ">
      <a class="nav-link" href="<%=request.getContextPath() %>/about.jsp"><i class='fas fa-smile'></i>관리자 소개</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<%=request.getContextPath() %>/departments/departmentsList.jsp"><i class='fas fa-bookmark'></i>departments</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<%=request.getContextPath() %>/employees/employeesList.jsp"><i class='fas fa-address-card'></i>employees</a>
    </li>
    <li class="nav-item">
      <a class="nav-link " href="<%=request.getContextPath() %>/deptEmp/deptEmpList.jsp"><i class='fas fa-briefcase'></i>deptemp</a>
    </li>
    <li class="nav-item">
      <a class="nav-link " href="<%=request.getContextPath() %>/deptManager/deptManagerList.jsp"><i class='fas fa-chart-bar'></i>deptManager</a>
    </li>
    
    <li class="nav-item">
      <a class="nav-link " href="<%=request.getContextPath() %>/titles/titlesList.jsp"><i class='far fa-clipboard'></i>titles</a>
    </li>
    <li class="nav-item">
      <a class="nav-link " href="<%=request.getContextPath() %>/salaries/salariesList.jsp"><i class='fas fa-bookmark'></i>salaries</a>
    </li>
    <li class="nav-item">
      <a class="nav-link " href="<%=request.getContextPath() %>/qna/qnaList.jsp"><i class='fas fa-bookmark'></i>Q&A게시판</a>
    </li>        
  </ul>
</nav>

