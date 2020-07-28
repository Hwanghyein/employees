<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %><!--ArrayList 선언 -->
<%@ page import="gd.emp.Employees" %><!--Employees 선언 -->
<%@ page import="java.sql.*" %><!-- java.sql 선언  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>employeesList</title>
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
	
	//1.페이지 셋팅
	int currentPage=1;//현재페이지
	if(request.getParameter("currentPage") !=null){//누가가 현재 페이지를 넘어오면 숫자로 바꿔서 현재페이지를 보여주세요.
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage:"+currentPage);
	
	int rowPerPage=200;//페이지 뽑아내는 갯수
	int beginRow=(currentPage-1)*rowPerPage;//시작하는 페이지에 번호의 수 정의
	String first_name;
	String last_name;
	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");//db사용설정
	Connection conn = null;//연결 정보를 받을 준비
	ArrayList<Employees> list =null;
	PreparedStatement stmt1=null;//쿼리의 보낼 준비
	ResultSet rs1=null;//결과문을 가져오기
	int lastPage=0;//마지막페이지 선언
	int totalRow=0;//테이블 총 카운트 0 초기값 선언
	PreparedStatement stmt2=null;//쿼리의 보낼 준비
	ResultSet rs2=null;//결과문을 가져오기
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://ghkdsla1.cafe24.com/ghkdsla1", "ghkdsla1", "java1004!");//db 연결
		System.out.print(conn);//연결정보 출력하기
		//2.현재페이지의 employees 테이블 행들
		list = new ArrayList<Employees>();//배열리스트 선언
		if(searchWord.equals("")){
			stmt1 = conn.prepareStatement("select emp_no,birth_date,first_name,last_name,gender,hire_date from employees_employees order by emp_no asc limit ?,?");//괄호안에 있는 것을 불러와서 stmt1에 저장해주세요.
			stmt1.setInt(1,beginRow);//1 시작하는 번호
			stmt1.setInt(2,rowPerPage);//2 뽑을 개수
		}else{
			stmt1 = conn.prepareStatement("select emp_no,birth_date,first_name,last_name,gender,hire_date from employees_employees where first_name like ? or last_name like? order by emp_no asc limit ?,?");//괄호안에 있는 것을 불러와서 stmt1에 저장해주세요.
			stmt1.setString(1,"%"+searchWord+"%");
			stmt1.setString(2,"%"+searchWord+"%");
			stmt1.setInt(3,beginRow);
			stmt1.setInt(4,rowPerPage);
		}
		rs1=stmt1.executeQuery();//결과물을 rs1로 받습니다.
		System.out.println(rs1);// rs1출력하기
		
		while(rs1.next()){//rs1.next()결과물이 false일때 {}안 코드를 반복해주세요.
			Employees e =new Employees();//Employees e 변수 선언
			e.empNo=rs1.getInt("emp_no");//employees에 emp_no에 가져와주세요.
			e.birthDate=rs1.getString("birth_date");//employees에 birth_date에 가져와주세요.
			e.firstName=rs1.getString("first_name");//employees에 first_name에 가져와주세요.
			e.lastName=rs1.getString("last_name");//employees에 last_name에 가져와주세요.
			e.gender=rs1.getString("gender");//employees에 gender에 가져와주세요.
			e.hireDate=rs1.getString("hire_date");//employees에 hire_date에 가져와주세요.
			list.add(e);//리스트에 e라는 추가해주세요
		}
		System.out.println(list.size());//리스트에 데이터가 들어가는지 확인하기
		
		//3.employess 테이블 전채행의수
		if(searchWord.equals("")){
			stmt2=conn.prepareStatement("select count(*) from employees_employees");
		}else{
			stmt2=conn.prepareStatement("select count(*) from employees_employees where first_name like ? or last_name like ?");
			stmt2.setString(1,"%"+searchWord+"%");
			stmt2.setString(2,"%"+searchWord+"%");
		}
		rs2=stmt2.executeQuery();//결과물(stmt2)을 rs2로 받습니다.
		System.out.println(rs2);//rs2출력하기
		if(rs2.next()){//rs2.next결과물이 false일때 {}안 코드를 실행주세요.
			totalRow= rs2.getInt("count(*)");//카운트*이 int형으로 rs2에 저장된 테이블의 총 카운트에 넣어주세요.
		}
		lastPage=totalRow/rowPerPage;//lastPagesms totalRow 나누기 rowPerPage 입니다.
		if(totalRow %rowPerPage !=0){//totalRow와 rowPerPage 나머지가 0이 아닐 경우에
			lastPage+=1;//lastPage를 하나를 더 해주세요.
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
	<div  class="container-fluid col-xl-10">
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	<h1>employeesList</h1>
	<form style="float:right" method="post" action="<%=request.getContextPath()%>/employees/employeesList.jsp">
	<input type="text" name="searchWord">
	<button class="btn btn-primary" type="submit">검색</button>
	</form>
	<table class="table table-dark table-hover"><!-- 테이블 생성 -->
		<thead>
			<tr>
				<th>empNo</th>
				<th>birthDate</th>
				<th>firstName</th>
				<th>lastName</th>
				<th>gender</th>
				<th>hireDate</th>
				<th>update</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Employees e :list){//Employees에 e변수 리스트 불러오기 
			%>
				<tr>
					<!-- 출력 -->
					<td><%=e.empNo %></td>
					<td><%=e.birthDate %></td>
					<td><%=e.firstName %></td>
					<td><%=e.lastName %></td>
					<td><%=e.gender %></td>
					<td><%=e.hireDate %></td>
					<td><a href="" class="btn btn-dark">수정</a></td>
				</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<ul class="pagination" style="justify-content: center;">
	<!-- currentPage가 1보다 클때만 이전페이지 링크 출력 -->
	<li class="page-item">
		<a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=1%>&searchWord=<%=searchWord%>">처음페이지</a>
		</li>
	<%
		if(currentPage >1){
	%>
		<li class="page-item">
		<a href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a><!-- 링크 employeesList.jsp으로 돌아가주세요.현재페이지는  현재페이지-1를하면돌아간다. -->
		</li>
	<%		
		}
	%>
	<!-- currentPage가  마지막페이지보다 작을때만  -->
	<%
		if(currentPage < lastPage){
	%>
		<li class="page-item">
			<a href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=currentPage+1 %>&searchWord=<%=searchWord%>">다음</a><!-- 링크는 employeesList.jsp으로 돌아가주세요.다음페이지는 현재페이지+1를 하면 넘어간다. -->
			</li>
	<%		
		}
	%>
		<li class="page-item">
			<a href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막페이지</a>
		</li>
	</ul>
	</div>
</body>
</html>