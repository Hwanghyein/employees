<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>      
<%
	request.setCharacterEncoding("utf-8");
	int qnaNo=Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("qnaNo:"+qnaNo);
	String comment=request.getParameter("comment");
	System.out.println("comment:"+comment);
	String commentPw=request.getParameter("commentPw");
	System.out.println("commentPw:"+commentPw);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn =null;
	PreparedStatement stmt1=null;
	ResultSet rs1=null;
	PreparedStatement stmt2=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://ghkdsla1.cafe24.com/ghkdsla1", "ghkdsla1", "java1004!");
		System.out.println("conn:"+conn);
		//commentNo 구하는 것
		 stmt1=conn.prepareStatement("select max(comment_no) from employees_qna_comment");
		rs1= stmt1.executeQuery();
		int commentNo=1;
		if(rs1.next()){
			commentNo= rs1.getInt("max(comment_no)")+1;
		}
		//입력
		stmt2=conn.prepareStatement("insert into employees_qna_comment(comment_no,qna_no,comment,comment_date,comment_pw)values(?,?,?,now(),?)");
		stmt2.setInt(1,commentNo);
		stmt2.setInt(2,qnaNo);
		stmt2.setString(3,comment);
		stmt2.setString(4,commentPw);
		stmt2.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs1.close();
		stmt1.close();
		stmt2.close();
		conn.close();
	}
	response.sendRedirect(request.getContextPath()+"/qna/selectQna.jsp?qnaNo="+qnaNo);
%>