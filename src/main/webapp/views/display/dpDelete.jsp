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
<c:if test="${result > 0 }">
	<script type="text/javascript">
		var preUrl = document.referrer.split("/")[6];
		alert("삭제 완료!");
		if (preUrl.includes("adminDisplay")){
			location.href="../admin/adminDisplay.na"
		}else{
			location.href="dpMain.do?tab=1";	
		}
	</script>
</c:if>
<c:if test="${result <= 0 }">
	<script type="text/javascript">
		alert("삭제 실패");
		history.go(-1);
	</script>
</c:if>
</body>
</html>