<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<style>
carousel-inner img {
		padding:150px;
		margin:150px;
		
		
  }
</style>
</head>
<body>
	<div class="container-fluid col-xl-10" >
	<!-- Navigeation MainMenu -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		<!-- 다른 페이지를  외부 데이터 못 가져오게 하기위해서<%=request.getContextPath() %> 한번 더 적어주면 안된다. /슬랙스에 주소값이 적혀있다. -->
	</div>
	<br>
	<div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators ">
    <li data-target="#demo" data-slide-to="0" class="active bg-dark"></li>
    <li data-target="#demo" data-slide-to="1" class="bg-dark"></li>
  </ul>

  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="./imgs/1.jpg" >
    </div>
    <div class="carousel-item">
      <img src="./imgs/2.jpg" >
    </div>
  </div>

  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon  bg-dark "></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon bg-dark"></span>
  </a>

</div>
	</div>
</body>
</html>