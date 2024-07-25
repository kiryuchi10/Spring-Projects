<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>환영합니다! 메인 페이지 - 로그인 및 회원가입</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }
        .container {
            text-align: center;
            background: #fff;
            padding: 40px 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            margin: 10px;
            font-size: 16px;
            border-radius: 5px;
            padding: 10px 20px;
        }
        .btn-login {
            background-color: #007bff;
            color: #fff;
        }
        .btn-signup {
            background-color: #28a745;
            color: #fff;
        }
        .btn-calendar {
            background-color: #17a2b8;
            color: #fff;
        }
        .footer {
            width: 100%;
            text-align: center;
            padding: 10px;
            background-color: #333333;
            color: #fff;
            position: absolute;
            bottom: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mb-4">환영합니다!</h1>
        <p class="lead mb-4">로그인 또는 회원가입을 해주세요</p>
        <a href="<c:url value='/user/login'/>" class="btn btn-custom btn-login">로그인</a>
        <a href="<c:url value='/user/join'/>" class="btn btn-custom btn-signup">회원가입</a>
        <a href="<c:url value='/user/calendar'/>" class="btn btn-custom btn-calendar">달력 보기</a>
         <a href="<c:url value='/user/summary'/>" class="btn btn-custom btn-calendar">주문결과요약 보기</a>
    </div>
    
    <div class="footer">
        <%@ include file="/WEB-INF/views/admin_includes/footer.jsp" %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
