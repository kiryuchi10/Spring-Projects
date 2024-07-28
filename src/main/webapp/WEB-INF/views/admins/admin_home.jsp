<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 디폴트 페이지</title>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/admins.css'/>">
</head>
<body>
	<%@ include file="/WEB-INF/views/admin_includes/navigation.jsp"%>

	<!-- Main content: 교재 주문목록과 계정 승인요청 브리핑 -->
	<div class="content">
		<h1>교재 주문목록</h1>
		<p>${orderCount}</p>
		<p class="parent">
			<a href="<c:url value='/admin/ordercheck'/>">보러가기</a>
		</p>


		<h1>계정 승인 요청</h1>
		<p>${userCount}</p>
		<p class="parent">
			<a href="<c:url value='/admin/usermanage'/>">보러 가기</a>
		</p>
	</div>

	<!-- Include footer -->
	<%@ include file="/WEB-INF/views/admin_includes/footer.jsp"%>
</body>
</html>
