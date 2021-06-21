<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section class="container_wide">
	<div class="container-table">
		<table>
			<tr>
				<th>전시번호</th><th>전시명</th><th>시작일</th><th>종료일</th><th>관람 시간</th><th>관람 장소</th><th>단일 관람료</th><th>할인율</th><th>관람료_성인</th><th>관람료_청소년</th><th>관람료_어린이</th><th>관련 태그</th><th>작가명</th><th>전화번호</th><th>홈페이지</th><th>삭제여부</th><th>작성자</th><th>수정</th><th>삭제</th>
			</tr>
			<c:if test="${empty list}">
				<tr><td colspan="17">조건에 맞는 회원정보가 존재하지 않습니다</td></tr>
			</c:if>
			<c:if test="${not empty list }">
				<c:forEach var="display" items="${list }">
					<tr>
						<td>${display.dno} </td>
						<td>${display.dname} </td>
						<td>${display.start_date} </td>
						<td>${display.end_date} </td>
						<td>${display.hours} </td>
						<td>${display.loc} </td>
						<td>${display.fee} </td>
						<td>${display.discount} </td>
						<td>${display.fee_adult} </td>
						<td>${display.fee_teen} </td>
						<td>${display.fee_child} </td>
						<td>${display.tag} </td>
						<td>${display.artist} </td>
						<td>${display.tel} </td>
						<td>${display.home_pg} </td>
						<td>${display.del} </td>
						<td>${display.mno} </td>
						<td><a href="../display/dpUpdateForm.do?dno=${display.dno}" class="btn btn_stroke btn_small">수정</a></td>
						<td><a onclick="del(${display.dno})" class="btn btn_small">삭제</a></td>
					</tr>
				</c:forEach>	
			</c:if>
		</table>
	</div>
	<!-- paging -->
	<div class="paging nums">
		<div class="items">
			<div class="prev_btn">
				<c:if test="${startPage > PAGE_PER_BLOCK}">
					<button class="first" onclick="location.href='adminMember.na?pageNum=${startPage-1}'">
						<img alt="이전" src="../../images/icons/arrow_left1.png">
						<img alt="이전" src="../../images/icons/arrow_left1.png">
					</button> 
				</c:if>
				<c:if test="${pageNum > 1}">
					<button class="prev" onclick="location.href='adminMember.na?pageNum=${currentPage - 1}'">
						<img alt="이전" src="../../images/icons/arrow_left1.png">
					</button>
				</c:if>
			</div>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<span id="page${i}" class="page_num" onclick="location.href='adminMember.na?pageNum=${i}'">${i}</span>
			</c:forEach>
			<div class="next_btn">
				<c:if test="${currentPage < totalPage}">
					<button class="next" onclick="location.href='adminMember.na?pageNum=${currentPage + 1}'">
						<img alt="다음" src="../../images/icons/arrow_right.png">
					</button>
				</c:if>
				<c:if test="${endPage < totalPage}">
					<button class="last" onclick="location.href='adminMember.na?pageNum=${endPage + 1}'">
						<img alt="다음" src="../../images/icons/arrow_right.png">
						<img alt="다음" src="../../images/icons/arrow_right.png">
					</button> 
				</c:if>
			</div> <!-- next_btn -->
		</div> <!-- number -->
	</div> <!-- paging -->	
</section>
</body>
</html>