<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>  
<%@ page import= "gd.emp.Departments" %>
<%@ page import="java.sql.*"%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>departmentsList</title>
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
	//serachWord 설정
	String searchWord="";
	if(request.getParameter("searchWord")!= null){
		searchWord=request.getParameter("searchWord");
	}
	System.out.println("serachWord:"+searchWord);
	
	//1.페이지 셋팅
	int currentPage=1;
	if(request.getParameter("currentPage")!= null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=3;//페이지 뽑아내는 갯수
	int beginRow=(currentPage-1)*rowPerPage;//시작하는 페이지에  배열의 수 
	
	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");//db접근
	Connection conn =null;
	//2.현재페이지의 departments 테이블 행들
	PreparedStatement stmt1 =null;
	ResultSet rs1=null;
	int lastPage=0;
	int totalRow=0;
	PreparedStatement stmt2 =null;
	ResultSet rs2=null;
	ArrayList<Departments> list=null;
	try{
	conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");
	

	
	if(searchWord.equals("")){
		stmt1 =conn.prepareStatement("select dept_no, dept_name from employees_departments order by dept_no asc limit ?,?");
		stmt1.setInt(1,beginRow);
		stmt1.setInt(2,rowPerPage);
	}else{
		stmt1 =conn.prepareStatement("select dept_no, dept_name from employees_departments where dept_name like ? order by dept_no asc limit ?,?");
		stmt1.setString(1, "%"+searchWord+"%");
		stmt1.setInt(2,beginRow);
		stmt1.setInt(3,rowPerPage);
	}
	System.out.println("stmt1:"+stmt1);
	rs1=stmt1.executeQuery(); //->ArrayList<Departments> list/ rs1 ->list
	 list = new ArrayList<Departments>();
	while(rs1.next()){
		Departments d= new Departments();
		d.deptNo= rs1.getString("dept_no");
		d.deptName=rs1.getString("dept_name");
		list.add(d);//list에 d를 추가한다.
	}
	System.out.println(list.size());
	
	//3.departments 테이블 전체행의수 
	if(searchWord.equals("")){
		stmt2=conn.prepareStatement("select count(*) from employees_departments");
	}else{
		stmt2=conn.prepareStatement("select count(*) from employees_departments where dept_name like ?");
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
	<h1>departmentsList</h1>
	<!-- 부서입력 버튼 -->
	<div>
		<a href="<%=request.getContextPath()%>/departments/insertDepartmentsForm.jsp" class="btn btn-dark">부서입력</a>
	</div>
	<form style="float:right" method="post" action="<%=request.getContextPath()%>/departments/departmentsList.jsp">
		<input type="text" placeholder="검색"  name="searchWord">
		<button class="btn btn-primary"  type="submit" >과목검색</button>
	</form>
	<!-- 리스트 -->
	<table class="table table-dark table-hover">
		<thead>
			<tr>
				<th>deptNo</th>
				<th>deptName</th>
				<th>update</th>
				
			</tr>
		</thead>
		<tbody>
			<%
				for(Departments d :list){
			%>
				<tr>
					<td><%=d.deptNo %></td>
					<td><%=d.deptName %></td>
					<td><a href="" class="btn btn-dark">수정</a></td>
					
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<ul class="pagination" style="justify-content: center;">
		<li class="page-item">
		<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=1%>&searchWord=<%=searchWord%>">처음페이지</a>
		</li>
	<%
		if(currentPage>1){
	%>
		 <li class="page-item">
		<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
		</li>
	<%
		}
	%>
	<%
		if(currentPage <lastPage){
	%>
		<li class="page-item">
			<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
			</li>
	<%		
		}
	%>
		<li class="page-item">
			<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막페이지</a>
		</li>
	</ul>
	</div>
</body>
</html>
