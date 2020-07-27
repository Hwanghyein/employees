<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import=" gd.emp.DeptManager" %> 
<%@ page import= "java.util.ArrayList" %>   
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deptManageerList</title>
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
	if(request.getParameter("searchWord")!=null){
		searchWord=request.getParameter("searchWord");
	}
	System.out.println("searchWord:"+searchWord);
	
	//1.페이지 셋팅
	int currentPage=1;
	if(request.getParameter("currentPage")!= null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage"+currentPage);
	int rowPerPage=10;
	int bgeinRow=(currentPage-1)*rowPerPage;
	
	Class.forName("org.mariadb.jdbc.Driver");//db접근
	Connection conn =null;
	ArrayList<DeptManager> list =null;
	PreparedStatement stmt1 =null;
	ResultSet rs1=null;
	int lastPage=0;
	int totalRow=0;
	PreparedStatement stmt2= null;
	ResultSet rs2=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
		System.out.print(conn);
		list =new ArrayList<DeptManager>();
		if(searchWord.equals("")){
			stmt1= conn.prepareStatement("select dept_no,emp_no,from_date,to_date from employees_dept_manager order by dept_no asc limit ?,?");
			stmt1.setInt(1, bgeinRow);
			stmt1.setInt(2,rowPerPage);
		}else{
			stmt1= conn.prepareStatement("select dept_no,emp_no,from_date,to_date from employees_dept_manager where dept_no like ? order by dept_no asc limit ?,?");
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setInt(2, bgeinRow);
			stmt1.setInt(3,rowPerPage);
		}
		rs1=stmt1.executeQuery();
		System.out.println(rs1);
		
		while(rs1.next()){
			DeptManager m = new DeptManager();
			m.deptNo =rs1.getString("dept_no");
			m.empNo=rs1.getInt("emp_no");
			m.fromDate=rs1.getString("from_date");
			m.toDate=rs1.getString("to_date");
			list.add(m);
		}
		System.out.println(list.size());
		
		if(searchWord.equals("")){
			stmt2=conn.prepareStatement("select count(*) from employees_dept_manager");
		}else{
			stmt2=conn.prepareStatement("select count(*) from employees_dept_manager where dept_no like ?");
			stmt2.setString(1,"%"+searchWord+"%");
		}
		rs2=stmt2.executeQuery();
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
	<h1>deptManagerList</h1>
	<form style="float:right" method="post" action="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp">
	<input type="text" name="searchWord">
	<button class="btn btn-primary"  type="submit">검색</button>
	</form>
	<table class="table table-dark table-hover">
		<thead>
			<tr>
				<th>deptNo</th>
				<th>empNo</th>
				<th>fromDate</th>
				<th>toDate</th>
				<th>update</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(DeptManager m :list){
			%>
				<tr>
					<td><%=m.deptNo %></td>
					<td><%=m.empNo %></td>
					<td><%=m.fromDate %></td>
					<td><%=m.toDate %></td>
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
		if(currentPage >1){
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
		</li>
	<% 		
		}
	%>
	<%
		if(currentPage <lastPage){
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
		</li>
	<%		
		}
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막페이지</a>
		</li>
	</ul>
	</div>
</body>
</html>