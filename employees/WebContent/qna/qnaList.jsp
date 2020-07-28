<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %> 
<%@ page import= "gd.emp.QnA"%> 
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
		request.setCharacterEncoding("utf-8");//서로 신호를 맞추는 것이다.
		//searchWord 설정
		String searchWord="";//기본값
		if(request.getParameter("searchWord")!= null){
			searchWord=request.getParameter("searchWord");
		}
		System.out.println("searchWord:"+searchWord);
		
		//curentPage 설정
		int currentPage=1;
		if(request.getParameter("currentPage")!= null){
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		System.out.println("currentPage:"+currentPage);
		
		//rowPerPage
		int rowPerPage=5;
		int beginRow=(currentPage-1)*rowPerPage;
		System.out.println("beginRow:"+beginRow);
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn=null;
		PreparedStatement stmt1 = null;
		ResultSet rs1=null;
		ArrayList<QnA> list=null;
		int lastPage=0;
		int totalCount=0;
		PreparedStatement stmt2=null;
		ResultSet rs2=null;
		try{
			conn =DriverManager.getConnection("jdbc:mariadb://ghkdsla1.cafe24.com/ghkdsla1", "ghkdsla1", "java1004!");
			//검색어 유뮤에 따라 동적 쿼리
			if(searchWord.equals("")){
				stmt1 =conn.prepareStatement("select qna_no,qna_title,qna_user,qna_date from employees_qna order by qna_no desc limit ?,?");//내용을 붙어주려고
				stmt1.setInt(1,beginRow);
				stmt1.setInt(2,rowPerPage);
			}else{
				/*
				select qna_no,qna_title,qna_user,qna_date
				from qna
				where qna_title like ?
				order by qna_no desc
				limit ?,?
				*/
				stmt1 =conn.prepareStatement("select qna_no,qna_title,qna_user,qna_date from employees_qna  where qna_title like ? order by qna_no desc limit ?,?");//내용을 붙어주려고
				stmt1.setString(1,"%"+searchWord+"%");
				stmt1.setInt(2,beginRow);
				stmt1.setInt(3,rowPerPage);
			}
			System.out.println("stmt1:"+stmt1);
			rs1=stmt1.executeQuery();
			list= new ArrayList<QnA>();
			while(rs1.next()){
				QnA qna = new QnA();
				qna.qnaNo=rs1.getInt("qna_no");
				qna.qnaTitle=rs1.getString("qna_title");
				qna.qnaUser=rs1.getString("qna_user");
				qna.qnaDate=rs1.getString("qna_date");
				list.add(qna);
			}
			System.out.println(list.size());
			
			//3.qna 테이블 전체행의수 
			if(searchWord.equals("")){
				stmt2=conn.prepareStatement("select count(*) from employees_qna");
			}else{
				stmt2=conn.prepareStatement("select count(*) from employees_qna where qna_title like ?");
				stmt2.setString(1,"%"+searchWord+"%");
			}
		
			rs2=stmt2.executeQuery();
			if(rs2.next()){
				totalCount=rs2.getInt("count(*)");
			}
			lastPage=totalCount/rowPerPage;
			if(totalCount%rowPerPage !=0){
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
		<h1>QnA List<small>전체글수:<%=totalCount%></small></h1>
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/qna/insertQnaForm.jsp">qna입력</a>
		<form method="post" style="float:right" action="<%=request.getContextPath()%>/qna/qnaList.jsp">
		<input type="text" name="searchWord">
		<button class="btn btn-primary" type="submit">제목검색</button>
		</form>
		<table class="table table-dark table-hover">
			<thead>
				<tr>
				<td>qna_no</td>
				<td>qna_titla</td>
				<td>qna_user</td>
				</tr>				
			</thead>
			<tbody>
				<%
					for(QnA q:list){
						//db의 문자열 날짜값중 일부를 추출해 문자열로 변경
						//jsp에서 오늘 날짜값중 일부를 추출 문자열로 변경
						//두 날짜 문자열을 비교해서 같은면 badge표시하기
						String qnaDateSub= q.qnaDate.substring(0,10);
						System.out.println(qnaDateSub);//0번째부터 10번째전까지 자라주세요.
						
						Calendar today=Calendar.getInstance();
						int year=today.get(Calendar.YEAR);
						int month=today.get(Calendar.MONTH)+1;
						String month2= ""+month;
						if(month<10){
							month2="0"+month;
						}
						int day=today.get(Calendar.DATE);
						String day2=""+day;
						if(day<10){
							day2="0"+day;
						}
						String strToday=year+"-"+month2+"-"+day2;
						System.out.println("strToday:"+strToday);
				%>
					<tr>
						<td><%=q.qnaNo %></td>
						<td><a href="<%=request.getContextPath()%>/qna/selectQna.jsp?qnaNo=<%=q.qnaNo%>"><%=q.qnaTitle %></a>
						<%
							if(strToday.equals(qnaDateSub)){
						%>
							<span class="badge badge-danger">new</span>
						<%		
							}
						%>
						</td>
						<td><%=q.qnaUser %></td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<ul class="pagination" style="justify-content: center;">
			<%
				if(currentPage>1){
			%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
				</li>
			<%
			}	
			%>
			<%
				if(currentPage <lastPage){
			%>
				 <li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
					</li>
			<% 		
				}
			%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage=lastPage%>&searchWord=<%=searchWord%>">마지막페이지</a>
				</li>
		</ul>
	</div>
</body>
</html>