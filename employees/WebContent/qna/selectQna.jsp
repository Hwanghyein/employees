<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>  
<%@ page import = "gd.emp.*" %>  
<%@ page import="java.util.ArrayList"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>select Qna</title>
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
	int qnaNo= Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println("qnaNo:"+qnaNo);
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=null;
	PreparedStatement stmt=null;
	ResultSet rs=null;
	QnA qna=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
			System.out.println("conn:"+conn);
			stmt =conn.prepareStatement("select qna_no,qna_title,qna_content,qna_user,qna_date from employees_qna where qna_no=?");
			stmt.setInt(1,qnaNo);
			System.out.println("stmt:"+stmt);
			rs= stmt.executeQuery();
			System.out.println("rs:"+rs);
			qna= new QnA();
			if(rs.next()){
				qna.qnaNo=rs.getInt("qna_no");
				qna.qnaTitle=rs.getString("qna_title");
				qna.qnaContent=rs.getString("qna_content");
				qna.qnaUser=rs.getString("qna_user");
				qna.qnaDate=rs.getString("qna_date");
			}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs.close();
		stmt.close();
	}
%>
<div class="container-fluid">
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<div>
		<a href="./qnaList.jsp">게시판 목록</a>
		</div>
	<h1>QnA상세보기</h1>
	<table class="table">
		<tr>
			<td>qna_no</td>
			<td><%=qna.qnaNo%></td>
		</tr>
		<tr>
			<td>qna_title</td>
			<td><%=qna.qnaTitle%></td>
		</tr>
		
		<tr>
			<td>qna_content</td>
			<td><%=qna.qnaContent%></td>
		</tr>
		<tr>
			<td>qna_user</td>
			<td><%=qna.qnaUser%></td>
		</tr>
		<tr>
			<td>qna_date</td>
			<td><%=qna.qnaDate.substring(0,10)%></td>
		</tr>
	</table>
		<!-- 수정, 삭제 -->
		<div>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/qna/updateQnaForm.jsp?qnaNo=<%=qna.qnaNo%>">수정</a>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/qna/deleteQnaForm.jsp?qnaNo=<%=qna.qnaNo%>">삭제</a>
		</div>
		<!--댓글 입력폼 -->
		<br>
		<form method="post" action="<%=request.getContextPath()%>/qna/insertCommentAction.jsp">
			<input type="hidden" name="qnaNo" value="<%=qna.qnaNo %>">
 			<div class="form-group">
    			<textarea class="form-control"  rows="2" id="comment" name="comment"></textarea>
  			</div>
  			<div class="form-group">
    			<label for="pwd">comment_pw</label>
    			<input type="password" class="form-control" id="commentPw" name="commentPw">
 			 </div>
 			 <button type="submit" class="btn btn-primary">댓글입력</button>
		<!--댓글 목록 -->
		<%
		int currentPage=1;
    	if(request.getParameter("currentPage")!=null){
    		currentPage=Integer.parseInt(request.getParameter("currentPage"));
    	}
    	int rowPerPage=5;
    	int beginRow=(currentPage-1)*rowPerPage;
    	System.out.println(currentPage + "<- currentPage");
    	System.out.println(beginRow + "<- beginRow");
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn2=null;
		ArrayList<qnaComment> list=null;
		PreparedStatement stmt1=null;
		ResultSet rs1=null;
		int lastPage=0;
		int totalRow=0;
		PreparedStatement stmt2= null;
		ResultSet rs2=null;
		try{
			conn2 =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
		System.out.println("conn2:"+conn2);
		list = new ArrayList<qnaComment>();
		 stmt1= conn.prepareStatement("select comment_no,comment from employees_qna_comment where qna_no=?  limit ?,? ");
		stmt1.setInt(1,qnaNo);
		stmt1.setInt(2,beginRow);
		stmt1.setInt(3,rowPerPage);
		rs1=stmt1.executeQuery();
		
		while(rs1.next()){
		qnaComment c=new qnaComment();
		c.commentNo=rs1.getInt("comment_no");
		c.comment=rs1.getString("comment");
		list.add(c);
	}
	System.out.println(list.size());
	
	 stmt2= conn.prepareStatement("select count(*) from employees_qna_comment");
	 rs2=stmt2.executeQuery();
	if(rs2.next()){
		totalRow=rs2.getInt("count(*)");
	}
	System.out.println("totalRow:"+totalRow);
	
	lastPage=totalRow/rowPerPage;
	if(totalRow%rowPerPage!=0){
		lastPage+=1;
	}
	System.out.println("lastPage:"+lastPage);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs1.close();
		stmt1.close();
		rs2.close();
		stmt2.close();
		conn2.close();
	}
	%>
		<h1>insertcommentList</h1>
		
		<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th>commentNo</th>
					<th>comment</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(qnaComment c :list){
				%>
					<tr>
						<td><%=c.commentNo %></td>
						<td><%=c.comment %></td>
					</tr>
				<%		
					}
				%>
			</tbody>
		</table>
		<ul class="pagination">
         <%
            if(currentPage>1){
         %>
            <li class="page-item">
               <a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=currentPage-1%>&qnaNo=<%=qna.qnaNo%>">이전</a>
            </li>
         <%
         }   
         %>
         <%
            if(currentPage <lastPage){
         %>
             <li class="page-item">
               <a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=currentPage+1%>&qnaNo=<%=qna.qnaNo%>">다음</a>
               </li>
         <%       
            }
         %>
      </ul>
		
</form>		
</div>	
</body>
</html>