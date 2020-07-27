<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%
	int qnaNo=Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("qnaNo:"+qnaNo);
	String qnaPw= request.getParameter("qnaPw");
	System.out.println("qnaPw:"+qnaPw);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=null;
	PreparedStatement stmt=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
		System.out.println("conn:"+conn);
		 stmt =conn.prepareStatement("delete from employees_qna where qna_no=? and qna_pw=?");
		stmt.setInt(1,qnaNo);
		stmt.setString(2,qnaPw);
		System.out.println("stmt:"+stmt);
		int row= stmt.executeUpdate();//1 or 0
		System.out.println("row:"+row);
		//비밀번호가 틀리면 deleteQna폼으로 돌아가주세요.
		if(row ==0){
			response.sendRedirect(request.getContextPath()+"/qna/deleteQnaForm.jsp?qnaNo="+qnaNo);
		}else{
			response.sendRedirect(request.getContextPath()+"/qna/qnaList.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		stmt.close();
		conn.close();
	}
	


%>
