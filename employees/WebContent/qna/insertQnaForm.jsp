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
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String msg="";
	if(request.getParameter("ck")!= null){
		msg="빈값이 있습니다.";
	}
%>
	<div class="container-fluid">
	<h1>QnA 입력폼<small class="text-danger"><%=msg%></small></h1>
	<form  method="post" action="<%=request.getContextPath() %>/qna/insertQnaAction.jsp">
		<!-- QnA 제목 입력 -->
  		<div class="form-group">
    		<label for="qnaTitle"> 제목:</label>
    		<input type="text" class="form-control" id="qnaTitle" name="qnaTitle">
  		</div>
  		
  		<!-- QnA 내용 입력 -->
 		<div class="form-group">
  			<label for="qnaContent">내용:</label>
  			<textarea class="form-control" rows="5" id="qnaContent" name="qnaContent"></textarea>
		</div>
		
		<!-- QnA 글쓴이 -->
		<div class="form-group">
    		<label for="qnaUser">글쓴이:</label>
    		<input type="text" class="form-control" id="qnaUser" name="qnaUser">
  		</div>
  		
		<!-- QnA 비밀번호-->
		<div class="form-group">
    		<label for="qnaPw">비밀번호:</label>
    		<input type="password" class="form-control" id="qnaPw" name="qnaPw">
  		</div>
  		
 		 <button type="submit" class="btn btn-primary">글입력</button>
	</form>	
	</div>
</body>
</html>