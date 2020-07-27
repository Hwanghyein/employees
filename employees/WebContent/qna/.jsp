<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int qnaNo=Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("qnaNo:"+qnaNo);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn= DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");
	System.out.println("conn:"+conn);
	PreparedStatement stmt =conn.prepareStatement("select qna_no,qna_title,qna_content,qna_user,qna_date from qna where qna_no=?");
	stmt.setInt(1,qnaNo);
	System.out.println("stmt:"+stmt);
	ResultSet rs= stmt.executeQuery();
	if(rs.next()){
%>
	<div class="container-fluid">
	<h1>QnA 수정 폼</h1>
	<form action="<%=request.getContextPath()%>/qna/updateQnaAction.jsp">
	<div>
		<label> No:</label>
	</div>
	<div>
		<input type="text" name="qnaNo" value='<%=rs.getInt("qnaNo") %>'>
	</div>
 	<div>

		<label>Title :</label>
	</div>
	<div>
		<input type="text" name="qnaTitle" value='<%=rs.getString("qnaTitle")%>'>
	</div>
	<div>
	
		<label>Content :</label>
	</div>
	<div>
		<input type="text" name="qnaContent" value='<%=rs.getString("qnaContent")%>'>
	</div>
 	<div>

		<label>User :</label>
	</div>
	<div>
		<input type="text" name="qnaUser" value='<%=rs.getString("qnaUser")%>'>
	</div>
	<div>
	
		<label>date :</label>
	</div>
	<div>
		<input type="text" name="qnaDate" value='<%=rs.getString("qnaDate")%>'>
	</div>
  <button type="submit">게시판 수정</button>
</form>
<% 		
	}
%>
</div>
</body>
</html>