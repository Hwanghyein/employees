<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %><!--ArrayList 선언 -->
<%@ page import="gd.emp.Titles" %><!--Employees 선언 -->
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
	String searchWord="";
	if(request.getParameter("searchWord")!=null){
		searchWord=request.getParameter("searchWord");
	}
	System.out.println("searchWord:"+searchWord);
	//1.페이지 셋팅
	int currentPage=1;
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=200;
	int beginRow=(currentPage-1)*rowPerPage;
	
	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn=null;
	ArrayList<Titles> list =null;
	PreparedStatement stmt1=null;
	ResultSet rs1=null;
	int lastPage=0;
	int totalRow=0;
	PreparedStatement stmt2=null;
	ResultSet rs2=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
		System.out.println(conn);
		
		list = new ArrayList<Titles>();
		if(searchWord.equals("")){
			stmt1= conn.prepareStatement("select emp_no,title,from_date,to_date from employees_titles order by emp_no asc limit ?,?");
			stmt1.setInt(1,beginRow);
			stmt1.setInt(2,rowPerPage);
		}else{
			stmt1= conn.prepareStatement("select emp_no,title,from_date,to_date from employees_titles where emp_no like ? order by emp_no asc limit ?,?");
			stmt1.setString(1,"%"+searchWord+"%");
			stmt1.setInt(2,beginRow);
			stmt1.setInt(3,rowPerPage);
		}
		rs1=stmt1.executeQuery();
		System.out.println(rs1);
		
		while(rs1.next()){
			Titles t = new Titles();
			t.empNo=rs1.getInt("emp_no");
			t.title=rs1.getString("title");
			t.fromDate=rs1.getString("from_date");
			t.toDate=rs1.getString("to_date");
			list.add(t);
		}
		System.out.println(list.size());
		
		if(searchWord.equals("")){
			stmt2=conn.prepareStatement("select count(*) from employees_titles");
		}else{
			stmt2=conn.prepareStatement("select count(*) from employees_titles where emp_no like ?");
			stmt2.setString(1,"%"+searchWord+"%");
		}
		rs2= stmt2.executeQuery();
		System.out.println(rs2);
		if(rs2.next()){
			totalRow=rs2.getInt("count(*)");
		}
		lastPage=totalRow/rowPerPage;
		if(totalRow % rowPerPage !=0){
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
	<h1>titlesList</h1>
	<form style="float:right" method="post" action="<%=request.getContextPath()%>/titles/titlesList.jsp">
	<input type="text" name="searchWord">
	<button class="btn btn-primary" type="submit">검색</button>
	</form>
	<table class="table table-dark table-hover"><!-- 테이블 생성 -->
		<thead>
			<tr>
				<th>empNo</th>
				<th>title</th>
				<th>fromDate</th>
				<th>toDate</th>
				<th>update</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Titles t :list){//Employees에 e변수 리스트 불러오기 
			%>
				<tr>
					<!-- 출력 -->
					<td><%=t.empNo %></td>
					<td><%=t.title %></td>
					<td><%=t.fromDate %></td>
					<td><%=t.toDate %></td>
					<td><a href="" class="btn btn-dark">수정</a></td>
				</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<ul class="pagination"style="justify-content: center;">
	<!-- currentPage가 1보다 클때만 이전페이지 링크 출력 -->
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=1%>&searchWord=<%=searchWord%>">처음페이지</a>
		</li>
	<%
		if(currentPage >1){
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
		</li>
	<%		
		}
	%>

	<!-- currentPage가  마지막페이지보다 작을때만  -->
	<%
		if(currentPage < lastPage){
	%>
		<li class="page-item">
			<a href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a><!-- 링크는 employeesList.jsp으로 돌아가주세요.다음페이지는 현재페이지+1를 하면 넘어간다. -->
			</li>
	<%		
		}
	%>
		<li class="page-item">
			<a href="<%=request.getContextPath()%>/titles/titlesList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막페이지</a>
		</li>
	</ul>
	</div>
</body>
</html>