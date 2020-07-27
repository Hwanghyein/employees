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
	int qnaNo= Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("qnaNo"+qnaNo);
%>
<div class="container-fluid">
		<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
	<h1>QNA 삭제</h1>
		<form action="<%=request.getContextPath()%>/qna/deleteQnaAction.jsp">
			<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
  		<div class="form-group">
    		<label for="qnaPw">비밀번호:</label>
    		<input type="password" class="form-control" id="qnaPw" name="qnaPw">
 		 </div>
 
  			<button type="submit" class="btn btn-primary">삭제</button>
		</form>
	</div>
</body>
</html>