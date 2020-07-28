<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>   
<%
	//request 인코딩 설정
	request.setCharacterEncoding("utf-8");
	//request 매개값설정(ip,title,content,user,pw)
	String qnaIp = request.getRemoteAddr();
	String qnaTitle=request.getParameter("qnaTitle");
	String qnaContent=request.getParameter("qnaContent");
	String qnaUser=request.getParameter("qnaUser");
	String qnaPw=request.getParameter("qnaPw");
	
	//매개값 공백이 있으며 폼으로 ck추가해서 되돌려 보낸다.
	if(qnaTitle.equals("")||qnaContent.equals("")||qnaUser.equals("")||qnaPw.equals("")){
		response.sendRedirect(request.getContextPath()+"/qna/insertQnaForm.jsp?ck=fail");
		return;//명령진행을 끝낸다.
	}
	
	System.out.println("ip:"+qnaIp);
	System.out.println("title:"+qnaTitle);
	System.out.println("content:"+qnaContent);
	System.out.println("user:"+qnaUser);
	System.out.println("pw:"+qnaPw);
	
	//qnaNo
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=null;
	PreparedStatement stmt1 =null;
	ResultSet rs1=null;
	PreparedStatement stmt2=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://ghkdsla1.cafe24.com/ghkdsla1", "ghkdsla1", "java1004!");
		stmt1 =conn.prepareStatement("select max(qna_no) from employees_qna");
		System.out.println("stmt1:"+stmt1);
		rs1=stmt1.executeQuery();
		System.out.println("rs:"+rs1);
		
		int qnaNo=1;
		//rs1 값이 있으면 qnaNo 그 값의 +1
		//else이면 qnaNo=1
		if(rs1.next()){
			qnaNo=rs1.getInt("max(qna_no)")+1;
		}
		System.out.println("qnaNo:"+qnaNo);
		//qna Date:sql문에서 now()함수를 사용한다.
		/*
			("insert into qna(qna_no,qna_title,qna_content,qna_user,qna_pw,qna_date,qna_ip) values(?,?,?,?,?,now(),?)")
		*/
		stmt2=conn.prepareStatement("insert into employees_qna(qna_no,qna_title,qna_content,qna_user,qna_pw,qna_date,qna_ip) values(?,?,?,?,?,now(),?)");
		stmt2.setInt(1,qnaNo);
		stmt2.setString(2, qnaTitle);
		stmt2.setString(3, qnaContent);
		stmt2.setString(4, qnaUser);
		stmt2.setString(5, qnaPw);
		stmt2.setString(6,qnaIp);
		stmt2.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs1.close();
		stmt1.close();
		stmt2.close();
		conn.close();
	}
	response.sendRedirect(request.getContextPath()+"/qna/qnaList.jsp");
%>