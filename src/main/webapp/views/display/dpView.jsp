<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("../../css/display/dpView.css");</style>
<c:set var="id" value='${sessionScope.id}'></c:set>
<c:set var="mno" value='${sessionScope.mno}'></c:set>
<script type="text/javascript">
	$(function() {
		// input range rate 조절
		$('input[type="range"]').on('change mousemove', function() {
			var val = ($(this).val() - $(this).attr('min')) / ($(this).attr('max') - $(this).attr('min'));

		    $(this).css('background-image',
		                '-webkit-gradient(linear, left top, right top, '
		                + 'color-stop(' + val + ', #ff5f06), '
		                + 'color-stop(' + val + ', #e4e4e4)'
		                + ')'
           	);
		    // span에 등록한 별점(range value) 넣기
		    $('#input_span').text($(this).val());
		});
		
		// scroll top
		$('.scroll_top').on('click', function(e) {
			e.preventDefault();
			$('html, body').animate({scrollTop: 0}, 200);
		});
		
		// scroll top button show/hide
		$(window).scroll(function() {
			if ($(this).scrollTop() > 300) {
				$('.scroll_top').fadeIn(500);
			} else {
				$('.scroll_top').fadeOut('slow');
			}
		});
		
		// 리뷰 수정
		$('.review_update').on('click', function() {
			$(this).parents('.like_box').siblings('.review').hide();
			$(this).parents('.like_box').siblings('input').show();
			$(this).parents('.like_box').siblings('input').focus();
			$(this).parent().hide(); // .show_btn
			$(this).parent().siblings().show(); // .hidden_btn
		});
		
		// 리뷰 수정 취소
		$('.hidden_btn a').on('click', function() {
			$(this).parent().hide(); // .hidden_btn
			$(this).parent().siblings().show(); // .show_btn
			$(this).parents('.like_box').siblings('.review').show();
			$(this).parents('.like_box').siblings('input').hide();
		});
	});
	
	// session check
	function sessionChk(name) {
		if (${empty id}) {
			var con = confirm("로그인이 필요합니다.");
			if (con) {				
				location.href="/semojeon/views/member/loginForm.na";
			}
		} else {
			// 예매 체크
			if (name == 'reserve') {
				location.href="reserveForm.do?dno=${display.dno}";
			}
		}
	}
	
	// 전시 삭제 confirm
	function del(name) {
		var con = confirm("전시를 정말 삭제하시겠습니까?");
		if (con) {
			location.href="dpDelete.do?dno=${display.dno }";
		}
	}
	
	// 리뷰 삭제 confirm
	function delReview() {
		var con = confirm("리뷰를 정말 삭제하시겠습니까?");
		if (con) {
			location.href="dpReviewDelete.do?dno=${display.dno }&mno=${mno }";
		}
	}
	
	// 리뷰 좋아요 제어
	function likes(rv_no) {
		if (${empty id}) {
			var con = confirm("로그인이 필요합니다.");
			if (con) {				
				location.href="/semojeon/views/member/loginForm.na";
			}
		} else {
			$.post("reviewLikes.do", "rv_no="+rv_no, function(data) {
				var imgSrc = data.split(',')[0];
				var likes = data.split(',')[1];
				
				$('.like_img'+rv_no).attr('src', imgSrc);
				$('.like_img'+rv_no).siblings('.count').text(likes);
			});
		}
	}
	
	// 북마크 제어
	function bookmark() {
		if (${empty id}) {
			var con = confirm("로그인이 필요합니다.");
			if (con) {				
				location.href="/semojeon/views/member/loginForm.na";
			}
		} else {
			$.post("bookmarkUpdate.do", "dno=${display.dno}", function(data) {
				$('.bookmark svg g').css('fill', data);
			});
		}
	}

	// 리뷰 페이징 스크롤 높이
	document.addEventListener("DOMContentLoaded", function() { // html load 이후
		if (${pageNum} > 1) {			
			window.scrollTo(0, $('.scrollTop').position().top);
		}
	})
</script>
</head>
<body>
	<div class="container_middle display_view_container">
		<!-- 상단 정보 -->
		<div class="display_view_top">
			<img src="../../upload/${display.poster }" alt="포스터">
			<div class="text_area">
				<!-- 평균 별점 -->
				<div class="star_avg">★★★★★︎ &nbsp;<span class="text">${star_rate }</span>︎</div>
				<h3 class="dname">${display.dname }</h3>
				<pre class="intro">${display.intro }</pre>
				<table class="bottom">
					<tr>
						<th>장소</th>
						<td>${display.spot }</td>
					</tr>
					<tr>
						<th>지역</th>
						<td>${display.loc }</td>
					</tr>
					<tr>
						<th>기간</th>
						<td>${display.start_date } ~ ${display.end_date }</td>
					</tr>
					<tr>
						<th>관람 가능 시간</th>
						<td>${display.hours }</td>
					</tr>
					<tr>
						<th style="vertical-align: top;">가격</th>
						<td>
							<c:if test="${display.fee != 0 }">
								<span>${display.fee }원</span><br>
							</c:if>
							<c:if test="${display.fee_adult != 0 }">
								성인 : <span>${display.fee_adult }원</span><br>
							</c:if>
							<c:if test="${display.fee_teen != 0 }">
								청소년 : <span>${display.fee_teen }원</span><br>
							</c:if>
							<c:if test="${display.fee_child != 0 }">
								어린이 : <span>${display.fee_child }원</span><br>
							</c:if>
						</td>
					</tr>
				</table>
					<div class="bottom_box">
						<div class="bookmark" onclick="bookmark()">
							<svg xmlns="http://www.w3.org/2000/svg" width="34" height="34" viewBox="0 0 34 34">
							    <g fill="${color }" fill-rule="evenodd">
							        <g stroke="#000" stroke-width="2.5">
							            <g>
							                <path d="M27 30L17.499 23.303 8 30 8 4 27 4z" transform="translate(-1642 -119) translate(1642 119)"/>
							            </g>
							        </g>
							    </g>
							</svg>
						</div>
						<button class="btn" onclick="sessionChk('reserve')">예매하기</button>
					</div>
			</div>
		</div>
		<!-- 상세 내용, 이미지 -->
		<div class="display_view_middle">
			<h4 class="sub_title">상세 내용</h4>
			<c:if test="${not empty display.detail_txt }">
				<p class="detail_txt">${display.detail_txt }</p>
			</c:if>
			<img alt="전시 상세" src="../../upload/${display.detail_img }">
		</div>
		<!-- 하단 내용, 리뷰, 리뷰 등록 -->
		<div class="display_view_bottom">
			<c:if test="${not empty display.artist }">
				<h4 class="sub_title">작가명</h4>
				<p class="detail_txt">${display.artist }</p>
			</c:if>
			<c:if test="${not empty display.tag }">
				<h4 class="sub_title">관련 태그</h4>
				<p class="detail_txt">${display.tag }</p>
			</c:if>
			<c:if test="${not empty display.tel }">
				<h4 class="sub_title">전화번호</h4>
				<p class="detail_txt">${display.tel }</p>
			</c:if>
			<c:if test="${not empty display.home_pg }">
				<h4 class="sub_title">홈페이지</h4>
				<p class="detail_txt">${display.home_pg }</p>
			</c:if>
			<h4 class="sub_title scrollTop">입장방식 안내</h4>
			<p class="detail_txt">현장에서 별도 티켓으로 교환 후 입장</p>
			
			<!-- 전시 수정, 삭제 버튼 -->
			<c:if test="${mno == display.mno }">
				<div class="container_bottom_right">
					<a href="dpUpdateForm.do?dno=${display.dno }" class="btn btn_stroke btn_small">수정</a>
					<a onclick="del()" class="btn btn_stroke btn_small">삭제</a>
				</div>
			</c:if>
			
			<!-- 리뷰 리스트 : start -->
			<h4 class="sub_title pd_bottom">리뷰 <span>${reviewCnt }</span></h4>
			<!-- 평균 별점 -->
			<div class="star_avg">★★★★★ &nbsp;<span class="text">${star_rate }</span>︎︎</div>
			<ul class="review_list_box">
				<c:forEach var="review" items="${list }">
					<li>
						<form action="dpReviewUpdate.do?dno=${display.dno }&rv_no=${review.rv_no }" method="post">
							<div class="profile">
								<img src="/semojeon/upload/${review.profile }" alt="프로필">
								<p class="nick_nm">${review.nick_nm }</p>
							</div>
							<p class="detail_txt review">
								${review.content }							
							</p>
							<!-- 수정 인풋 -->
							<input type="text" name="content" class="detail_txt review" value="${review.content }">
							<div class="like_box">
								<img class="like_img${review.rv_no }" alt="좋아요" src="../../images/icons/heart.png" onclick="likes(${review.rv_no })">
								<!-- review 좋아요 한 회원일때 빨간하트로 세팅 -->
								<c:forEach var="rvList" items="${rvList }">
									<c:if test="${rvList.rv_no == review.rv_no }">
										<c:if test="${rvList.mno == mno }">
											<script type="text/javascript">$('.like_img'+${review.rv_no}).attr('src', '../../images/icons/heart-fill.png');</script>
										</c:if>
									</c:if>
								</c:forEach>
								<p class="count">${review.likes }</p>
								<c:if test="${mno == review.mno }">
									<div class="rievew_btn">
										<div class="show_btn">
											<a class="btn btn_stroke btn_small review_update">수정</a>
											<a onclick="delReview()" class="btn btn_stroke btn_small">삭제</a>
										</div>
										<!-- 수정시 나타나는 확인 취소 버튼 -->
										<div class="hidden_btn">								
											<input type="submit" class="btn btn_stroke btn_small" value="완료">
											<a class="btn btn_stroke btn_small">취소</a>
										</div>
									</div>
								</c:if>
							</div>
						</form>
					</li>
				</c:forEach>
			</ul>
			<!-- 리뷰 리스트 : end -->
			
			<!-- paging -->
			<div class="paging">
				<div class="items">
					<div class="prev_btn">
						<c:if test="${pageNum > 1}">
							<button class="prev" onclick="location.href='dpView.do?dno=${display.dno }&pageNum=${currentPage - 1}'">
								<img alt="이전" src="../../images/icons/arrow_left1.png">
							</button>
						</c:if>
					</div>
					<span class="page_num">${pageNum}</span>
					<span>/</span>
					<span class="page_num">${totalPage}</span>
					<div class="next_btn">
						<c:if test="${currentPage < totalPage}">
							<button class="next" onclick="location.href='dpView.do?dno=${display.dno }&pageNum=${currentPage + 1}'">
								<img alt="다음" src="../../images/icons/arrow_right.png">
							</button>
						</c:if>
					</div> <!-- next_btn -->
				</div> <!-- number -->
			</div> <!-- paging -->
			
			<!-- 리뷰 등록 -->
			<form action="dpReviewWrite.do?dno=${display.dno }" method="post">
				<h4 class="sub_title">리뷰와 별점 등록</h4>
				<textarea name="content" placeholder="전시가 어떠셨나요? 감상평을 작성해주세요." required onclick="sessionChk()"></textarea>
				<p class="detail_txt pd_bottom">별점을 선택해주세요.</p>
				<!-- 별점 등록 -->
				<div class="star_avg rate">
					<input type="range" name="star_rate" min="0" max="10" step="1" value="0" required>
					<span class="text" id="input_span">0</span>
				</div>
				<div class="submit_box">
					<input type="submit" class="btn" value="등록하기">
				</div>
			</form>
		</div>
	</div>
	<div class="scroll_top"><div class="arrow"></div></div>
</body>
</html>