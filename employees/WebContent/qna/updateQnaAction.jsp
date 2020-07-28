<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>\
<%@ page import="java.sql.*" %>    
<%
	request.setCharacterEncoding("utf-8");
	int qnaNo= Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("qna_no:"+qnaNo);
	String qnaTitle= request.getParameter("qnaTitle");
	System.out.println("qna_title:"+qnaTitle);
	String qnaContent= request.getParameter("qnaContent");
	System.out.println("qna_content:"+qnaContent);
	String qnaUser= request.getParameter("qnaUser");
	System.out.println("qna_user:"+qnaUser);
	String qnaDate= request.getParameter("qnaDate");
	System.out.println("qna_date:"+qnaDate);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =null;
	PreparedStatement stmt=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://ghkdsla1.cafe24.com/ghkdsla1", "ghkdsla1", "java1004!");
	stmt=conn.prepareStatement("update employees_qna set qna_title=?,qna_content=?,qna_user=?,qna_date=? where qna_no=?");
	stmt.setString(1,qnaTitle);
	stmt.setString(2,qnaContent);
	stmt.setString(3,qnaUser);
	stmt.setString(4,qnaDate);
	stmt.setInt(5,qnaNo);
	stmt.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		stmt.close();
		conn.close();
	}
	response.sendRedirect("./qnaList.jsp");
%>