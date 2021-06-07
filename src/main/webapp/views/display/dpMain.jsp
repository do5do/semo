<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="dao.*, model.*, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url("../../css/display/dpMain.css");
</style>
<script type="text/javascript">
	$(function() {
		// tab active
		$('.display_tab li').on('click', function() {
			if (!$(this).hasClass('active')) {
				$('.display_tab li').removeClass('active');
				$(this).addClass('active');
			}
		})

		// filter modal open
		$('.filter').on('click', function() {
			$('.filter_modal').show();
			$('html body').css('overflow', 'hidden');
		})

		// filter modal close
		$('.close, .dim_box, .btn').on('click', function() {
			$('.filter_modal').hide();
			$('html body').css('overflow', 'auto');
		})

		// tag active : loc
		$('input[name="loc"]').on('change', function() {
			if ($(this).is(":checked")) {
				$(this).siblings("label").addClass('active');
			} else {
				$(this).siblings("label").removeClass('active');
			}
		})

		// tag active : tag
		$('input[name="tag"]').on('change', function() {
			if ($(this).is(":checked")) {
				$(this).siblings("label").addClass('active');
			} else {
				$(this).siblings("label").removeClass('active');
			}
		})
	})

	// tab 페이지 새로고침 없이 url 변경
	/* function uriRedirect1() {
		var url = "dpMain.do?tab=1";
		history.pushState(null, null, url);
		
	}

	function uriRedirect2() {
		var url = "dpMain.do?tab=2";
		history.pushState(null, null, url);
	}

	function uriRedirect3() {
		var url = "dpMain.do?tab=3";
		history.pushState(null, null, url);
	} */
	// console.log(${servletPath}) /views/display/dpMain.do
</script>
</head>
<body>
	<div class="container_wide">
		<section class="display_main">
			<ul class="display_tab">
				<li class="title active" onclick="location.href='dpMain.do?tab=1'">전시중</li>
				<li class="title" onclick="uriRedirect2()">종료 예정</li>
				<li class="title" onclick="uriRedirect3()">예정 전시</li>
			</ul>

			<div class="button_box">
				<!-- 필터 -->
				<a href="#" class="filter"> <img alt="필터"
					src="../../images/icons/filter.png"> <span>필터</span>
				</a>
				<!-- 전시 등록 버튼 -->
				<div class="confirm_btn">
					<button class="btn btn_stroke"
						onclick="location.href='dpRegistForm.do'">전시 등록하기</button>
				</div>
			</div>

			<!-- display list -->
			<div class="display_list">
				<ul>
					<c:forEach var="display" items="${list }">
						<!-- 전시중 -->
						<c:if test="${display.start_date <= today }">
							<%-- <c:set var="url" value="${servletPath}" /> --%>
								<li>
									<a href="#"> 
										<img alt="포스터" src="/semojeon/upload/${display.poster }">
										<div class="text_area">
											<p class="date">${display.start_date }~ ${display.end_date }</p>
											<p class="dp_list_title">${display.dname }</p>
											<p class="location">${display.loc }</p>
										</div>
									</a>
								</li>
						</c:if>
					</c:forEach>
					<!-- 종료 예정 -->
					<%-- <c:if test="${display.end_date >= today && display.end_date <= todayAfter7 }">
						<c:forEach var="display" items="${list }">
							<li>
								<a href="#"> 
									<img alt="포스터" src="/semojeon/upload/${display.poster }">
									<div class="text_area">
										<p class="date">${display.start_date }~ ${display.end_date }</p>
										<p class="dp_list_title">${display.dname }</p>
										<p class="location">${display.loc }</p>
									</div>
								</a>
							</li>
						</c:forEach>
					</c:if>
					<!-- 예정 전시 -->
					<c:if test="${display.end_date >= today && display.end_date <= todayAfter7 }">
						<c:forEach var="display" items="${list }">
							<li>
								<a href="#"> 
									<img alt="포스터" src="/semojeon/upload/${display.poster }">
									<div class="text_area">
										<p class="date">${display.start_date }~ ${display.end_date }</p>
										<p class="dp_list_title">${display.dname }</p>
										<p class="location">${display.loc }</p>
									</div>
								</a>
							</li>
						</c:forEach>
					</c:if> --%>
				</ul>
			</div>

			<!-- paging -->
			<div class="paging">
				<button class="prev">
					<img alt="이전" src="../../images/icons/arrow_left.png">
				</button>
				<div class="number">
					<span class="page_num">1</span> / <span>6</span>
				</div>
				<button class="next">
					<img alt="이전" src="../../images/icons/arrow_right.png">
				</button>
			</div>
		</section>
	</div>

	<!-- modal -->
	<div class="filter_modal">
		<div class="dim_box"></div>
		<div class="modal_content">
			<img class="close" src="../../images/icons/close.png"></img>
			<div class="content_inner">
				<!-- left -->
				<div class="block">
					<p class="modal_title">지역</p>
					<div class="tag_box">
						<!-- tag -->
						<div class="label_box">
							<label class="tag active" for="l1">서울</label><input
								type="checkbox" name="loc" id="l1" value="l1" checked="checked">
						</div>
						<div class="label_box">
							<label class="tag" for="l2">서울</label><input type="checkbox"
								name="loc" id="l2" value="l2">
						</div>
						<div class="label_box">
							<label class="tag" for="l3">서울</label><input type="checkbox"
								name="loc" id="l3" value="l3">
						</div>
						<div class="label_box">
							<label class="tag" for="l4">서울</label><input type="checkbox"
								name="loc" id="l4" value="l4">
						</div>
						<div class="label_box">
							<label class="tag" for="l5">서울</label><input type="checkbox"
								name="loc" id="l5" value="l5">
						</div>
						<div class="label_box">
							<label class="tag" for="l6">서울</label><input type="checkbox"
								name="loc" id="l6" value="l6">
						</div>
					</div>
				</div>
				<div class="block">
					<p class="modal_title">태그</p>
					<div class="tag_box">
						<!-- tag -->
						<div class="label_box">
							<label class="tag active" for="t1">혼자보기좋은</label><input
								type="checkbox" name="tag" id="t1" value="t1" checked>
						</div>
						<div class="label_box">
							<label class="tag" for="t2">갬성</label><input type="checkbox"
								name="tag" id="t2" value="t2">
						</div>
					</div>
				</div>
			</div>
			<div class="btn_box">
				<button class="btn">확인</button>
			</div>
		</div>
	</div>
</body>
</html>