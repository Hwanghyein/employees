<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>  
<%@ page import= "gd.emp.*" %>
<%@ page import="java.sql.*"%>  
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
	System.out.println("serachWord:"+searchWord);
	
	int currentPage=1;
	if(request.getParameter("currentPage")!= null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=10;//페이지 뽑아내는 갯수
	int beginRow=(currentPage-1)*rowPerPage;//시작하는 페이지에  배열의 수 
	
	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");//db접근
	Connection conn =null;
	PreparedStatement stmt1 =null;
	ResultSet rs1=null;
	ArrayList<Join> list =null;
	int lastPage=0;
	int totalRow=0;
	PreparedStatement stmt2 =null;
	ResultSet rs2=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
		
		if(searchWord.equals("")){
			stmt1 =conn.prepareStatement("select ep.emp_no, ep.first_name, ep.last_name, ep.gender, dp.dept_name, de.from_date, de.to_date FROM employees_dept_emp de inner join employees ep ON ep.emp_no = de.emp_no INNER JOIN departments dp ON de.dept_no = dp.dept_no limit ?,?");
			stmt1.setInt(1,beginRow);
			stmt1.setInt(2,rowPerPage);
		}else{
			stmt1 =conn.prepareStatement("select ep.emp_no, ep.first_name, ep.last_name, ep.gender, dp.dept_name, de.from_date, de.to_date FROM employees_dept_emp de inner join employees ep ON ep.emp_no = de.emp_no INNER JOIN departments dp ON de.dept_no = dp.dept_no where ep.emp_no like ? limit ?,?");
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setInt(2,beginRow);
			stmt1.setInt(3,rowPerPage);
		}
		System.out.println("stmt1:"+stmt1);
		rs1=stmt1.executeQuery(); 
		 list = new ArrayList<Join>();
		while(rs1.next()){
			Join j= new Join();
			j.empNo= rs1.getInt("emp_no");
			j.firstName=rs1.getString("first_name");
			j.lastName=rs1.getString("last_name");
			j.gender=rs1.getString("gender");
			j.deptName=rs1.getString("dept_name");
			j.fromDate=rs1.getString("from_date");
			j.toDate=rs1.getString("to_date");
			list.add(j);//list에 d를 추가한다.
		}
		System.out.println(list.size());
		
		//3.departments 테이블 전체행의수 
		if(searchWord.equals("")){
			stmt2=conn.prepareStatement("select count(*) from dept_emp de inner join employees ep ON ep.emp_no = de.emp_no INNER JOIN departments dp ON de.dept_no = dp.dept_no");
		}else{
			stmt2=conn.prepareStatement("select count(*) from dept_emp de inner join employees ep ON ep.emp_no = de.emp_no INNER JOIN departments dp ON de.dept_no = dp.dept_no where ep.emp_no like ?");
			stmt2.setString(1,"%"+searchWord+"%");
		}
		rs2= stmt2.executeQuery();
		if(rs2.next()){
			totalRow= rs2.getInt("count(*)");
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
	<h1>joinList</h1>
	<form style="float:right" method="post" action="<%=request.getContextPath()%>/join.jsp">
		<input type="text" placeholder="검색"  name="searchWord">
		<button class="btn btn-primary"  type="submit" >검색</button>
	</form>
	<table class="table table-dark table-hover">
		<thead>
			<tr>
				<th>emp_no</th>
				<th>first_name</th>
				<th>last_name</th>
				<th>gender</th>
				<th>dept_name</th>
				<th>from_date</th>
				<th>to_date</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Join j :list){
			%>
				<tr>
					<td><%=j.empNo %></td>
					<td><%=j.firstName %></td>
					<td><%=j.lastName %></td>
					<td><%=j.gender %></td>
					<td><%=j.deptName %></td>
					<td><%=j.fromDate %></td>
					<td><%=j.toDate %></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<ul class="pagination" style="justify-content: center;">
		<li class="page-item">
		<a class="page-link" href="<%=request.getContextPath()%>/join.jsp?currentPage=<%=1%>&searchWord=<%=searchWord%>">처음페이지</a>
		</li>
	<%
		if(currentPage>1){
	%>
		 <li class="page-item">
		<a class="page-link" href="<%=request.getContextPath()%>/join.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
		</li>
	<%
		}
	%>
	<%
		if(currentPage <lastPage){
	%>
		<li class="page-item">
			<a class="page-link" href="<%=request.getContextPath()%>/join.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
			</li>
	<%		
		}
	%>
		<li class="page-item">
			<a class="page-link" href="<%=request.getContextPath()%>/join.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막페이지</a>
		</li>
	</ul>
	</div>
</body>
</html>