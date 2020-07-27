<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	//열:dept_no,dept_name
	//deptno 구하기
	//dept_no 가장 큰수를 찾아오는  알고리즘(가장 큰수를 찾아와서 다음 dept_no를 구하기 자동으로 나올 수 있도록 만들것이다)
	Class.forName("org.mariadb.jdbc.Driver");//db셋팅
	Connection conn =null;
	PreparedStatement stmt=null;
	ResultSet rs=null;
	PreparedStatement stmt2=null;
	try{
		conn =DriverManager.getConnection("jdbc:mariadb://localhost/ghkdsla1", "ghkdsla1", "java1004!");//db접근
	 stmt =conn.prepareStatement("select dept_no from employees_departments order by dept_no desc limit 0,1");//괄호안에 있는 데이터 조건을 가져와주세요.
	 rs=stmt.executeQuery();//결과물을 rs로 받습니다.
	String deptNo="";//deptNo 초기화
	if(rs.next()){//rs으로 첫번째 페이지를 읽어와주세요.
		deptNo= rs.getString("dept_no");
	}
	System.out.println(deptNo);
	
	String deptNo2= deptNo.substring(1);//둘번째부터 자라주세요.
	System.out.println(deptNo2);
	
	int deptNo3=Integer.parseInt(deptNo2);//deptNo2를 숫자로 바꿔주세요.
	System.out.println(deptNo3);
	
	int nextDeptNo= deptNo3+1;//바꿔숫자를 1를 더해주세요.
	System.out.println(nextDeptNo);
	
	String nextDeptNo2="";//nextDepNo2초기화
	
	if(nextDeptNo/100 >0){//정수 나누기 정수는 정수가 나오다.
		nextDeptNo2= "d"+nextDeptNo;
	}else if(nextDeptNo/10 >0){
		nextDeptNo2= "d0"+nextDeptNo;
	}else{
		nextDeptNo2= "d00"+nextDeptNo;
	}
	System.out.println(nextDeptNo2); //dept_no 구하기
	
	//dept_name 불러오기
	String deptName=request.getParameter("deptName");
	 stmt2 =conn.prepareStatement("insert into employees_departments(dept_no, dept_name) values(?,?)");
	stmt2.setString(1,nextDeptNo2);
	stmt2.setString(2,deptName);
	stmt2.executeUpdate();//실행 할 수 있는 만들다. 
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs.close();
		stmt.close();
		stmt2.close();
		conn.close();
	}
	response.sendRedirect(request.getContextPath()+"/departments/departmentsList.jsp");
	
%>
</body>
</html>