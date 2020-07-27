<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="gd.emp.Salaries" %>
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
	request.setCharacterEncoding("utf-8");
	String searchWord="";
	if(request.getParameter("searchWord")!= null){
		searchWord=request.getParameter("searchWord");
	}
	System.out.println("searchWord:"+searchWord);
	int currentPage=1;
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=200;
	int beginRow= (currentPage-1)*rowPerPage;
	
	//2.0datebase
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=null;
	PreparedStatement stmt1=null;
	ArrayList<Salaries> list =null;
	ResultSet rs1=null;
	int lastPage=0;
	int totalRow=0;
	PreparedStatement stmt2=null;
	ResultSet rs2=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
		System.out.println(conn);
		
		list =new ArrayList<Salaries>();
		if(searchWord.equals("")){
			stmt1= conn.prepareStatement("select emp_no,salary,from_date,to_date from employees_salaries order by emp_no limit ?,?");
			stmt1.setInt(1,beginRow);
			stmt1.setInt(2,rowPerPage);
		}else{
			stmt1= conn.prepareStatement("select emp_no,salary,from_date,to_date from employees_salaries where emp_no like ? order by emp_no limit ?,?");
			stmt1.setString(1,"%"+searchWord+"%");
			stmt1.setInt(2,beginRow);
			stmt1.setInt(3,rowPerPage);
		}
		rs1= stmt1.executeQuery();
		System.out.println(rs1);
		
		while(rs1.next()){
			Salaries s = new Salaries();
			s.empNo=rs1.getInt("emp_no");
			s.salary=rs1.getInt("salary");
			s.fromDate=rs1.getString("from_date");
			s.toDate=rs1.getString("to_date");
			list.add(s);
		}
		System.out.println(list.size());
		
		//3. salaries테이블의 전체 행의 수
		if(searchWord.equals("")){
			 stmt2= conn.prepareStatement("select count(*) from employees_salaries");
		}else{
			 stmt2= conn.prepareStatement("select count(*) from employees_salaries where emp_no like ?");
			stmt2.setString(1, "%"+searchWord+"%");
		}
		rs2=stmt2.executeQuery();
		System.out.println(rs2);
		if(rs2.next()){
			totalRow=rs2.getInt("count(*)");
		}
		lastPage=totalRow/rowPerPage;
		if(totalRow%rowPerPage !=0){
			lastPage+=1;
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs1.close();
		stmt1.close();
		rs2.close();
		stmt2.close();
		conn.close();
	}
%>
	<div class="container-fluid col-xl-10">
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	<h1>salariesList</h1>
	<form style="float:right" method="post" action="<%=request.getContextPath()%>/salaries/salariesList.jsp">
	<input type="text" name="searchWord">
	<button  class="btn btn-primary" type="submit">검색</button>
	</form>
	<table class="table table-dark table-hover">
		<thead>
			<tr>
				<th>empNo</th>
				<th>salary</th>
				<th>fromDate</th>
				<th>toDate</th>
				<th>update</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Salaries s :list){
			%>
				<tr>
					<td><%=s.empNo%></td>
					<td><%=s.salary %></td>
					<td><%=s.fromDate %></td>
					<td><%=s.toDate %></td>
					<td><a href="" class="btn btn-dark">수정</a></td>
				</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<ul class="pagination" style="justify-content: center;">
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=1%>&searchWord=<%=searchWord%>">처음페이지</a>
		</li>
	<%
		if(currentPage>1){
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/salaries/salariesList.jsp?currentPage=<%=currentPage-1 %>&searchWord=<%=searchWord%>">이전</a>
		</li>
	<% 		
		}
	%>
	<%
		if(currentPage<lastPage){
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/salaries/salariesList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
		</li>
	<%		
		}
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/salaries/salariesList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막페이지</a>
		</li>
	</ul>
	</div>
</body>
</html>