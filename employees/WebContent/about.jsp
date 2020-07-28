<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>about</title>
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
<div class= "container-fluid col-xl-10">
	<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
<div class="container" >
	<h1>이력서</h1>
	<!-- 기본정보 -->
	<table class="table table-bordered">
		<tbody>
			<tr >
				<td  width="100" height="150" rowspan="3" ><img src="<%=request.getContextPath()%>/imgs/hyein.jpg" width="150" height="200" padding:0px;  class="rounded"></td>
				<td  rowspan="2" class="text-white bg-dark" >성명</td>
				<td  >(한글) 황혜인</td>
				<td   class="text-white bg-dark ">생년월일</td>
				<td >1997년08월18일</td>
			</tr>
			<tr  >
				<!-- <td>사진</td> -->
				<td >(영문) HWANG HYE IN</td>
				<td  class="text-white bg-dark">휴대폰</td>
				<td>010-4967-7612</td>
			</tr>
			<tr>
				<!-- <td>사진</td> -->
				<td class="text-white bg-dark">현주소 </td>
				<td > 인천광역시 부평구 장제로249번길 26-7</td>
				<td class="text-white bg-dark">이메일 </td>
				<td>dev_23@naver.com</td>
			</tr>
		</tbody>
	</table>
	<!-- 학력사항 -->
	<table class="table table-bordered" width="100" height="150">
		<tbody>
			<tr>
				<th  width="100" height="150" rowspan="5"class="text-white bg-dark">학력사항</th>
				<th class="text-white bg-dark">졸업일</th>
				<th class="text-white bg-dark">학교명</th>
				<th class="text-white bg-dark">전공</th>
				<th class="text-white bg-dark">졸업여부</th>
				<th class="text-white bg-dark">성적</th>
			</tr>
			<tr>
				
				<td>2016년 2월</td>
				<td>인천부흥고등학교</td>
				<td>문과계열</td><!-- 전공 -->
				<td>졸업</td><!-- 졸업여부 -->
				<td>/</td>
			</tr>
			<tr>
				
				<td>2019년 2월</td>
				<td>인하공업전문대학</td>
				<td>컴퓨터 정보과</td><!-- 전공 -->
				<td>졸업</td><!-- 졸업여부 -->
				<td>2.89/4.5</td>
			</tr>
		</tbody>
	</table>
	
	<!-- 기타사항 -->
	<table class="table table-bordered" >
		<tbody >
			<tr>
				<th width="100" height="150" rowspan="6"class="text-white bg-dark">기타사항</th>
				
				
				<tr>
				<th rowspan="4"class="text-white bg-dark">전산능력</th>
				<th class="text-white bg-dark">프로그랭명</th>
				<th class="text-white bg-dark">활용도</th>
				<th class="text-white bg-dark"colspan="3">자격증보유현황</th>
				</tr>
			<tr>
				<td>워드프로세서</td>
				<td>문서작성을 할 수 있다.</td>
				<td colspan="3">워드프로세서 3급 자격증보유</td>
			</tr>
			<tr>
				<td>정보처리산업기사</td>
				<td>소프트웨어 개발을 할 수 있다.</td>
				<td colspan="3">정보처리산업기사 필기만 합격</td>
			</tr>
			
		</tbody>
	</table>
</div>
</body>
</html>