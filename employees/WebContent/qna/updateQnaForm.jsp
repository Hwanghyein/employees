<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
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
	System.out.println("qnaNo:"+qnaNo);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =null;
	PreparedStatement stmt=null;
	ResultSet rs= null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
		System.out.println("conn:"+conn);
		stmt=conn.prepareStatement("select qna_no, qna_title, qna_content, qna_user, qna_date from employees_qna where qna_no=?");
		stmt.setInt(1,qnaNo);
		rs= stmt.executeQuery();
		System.out.println("rs:"+rs);
		if(rs.next()){
%>
	<div class="container-fluid">
	<h1>게시판 수정 폼</h1>
	<div>
		<a href="./qnaList.jsp">게시판 목록</a><!-- get 방식  오픈 비닐-->
	</div>
	<form action="<%=request.getContextPath()%>/qna/updateQnaAction.jsp">
	<div class="form-group">
		<label for="qnaNo">no :</label>
		<input type="text" id="qnaNo" name="qnaNo" value='<%=rs.getInt("qna_no")%>' readonly="readonly">
	</div>
	<div class="form-group">
		<label for="qnaTitle">title :</label>
		<input type="text" id="qnaTitle"name="qnaTitle" value='<%=rs.getString("qna_title")%>'>
	</div>
	<div class="form-group">
		<label for="qnaContent">content :</label>
		<input type="text" id="qnaContent"name="qnaContent" value='<%=rs.getString("qna_content")%>'>
	</div>
	<div class="form-group">
		<label for="qnaUser">user :</label>
		<input type="text" id="qnaUser" name="qnaUser" value='<%=rs.getString("qna_user")%>' readonly="readonly">
	</div>
	<div>
		<label class="form-group">date:</label>
		<input type="text" id="qnaDate"name="qnaDate" value='<%=rs.getString("qna_date")%>'>
	</div>
	<div>
		<button type="submit" class="btn btn-primary">게시판 수정</button>
	</div>
</form>
<%	
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs.close();
		stmt.close();
		conn.close();
	}
%>
</div>
</body>
</html>