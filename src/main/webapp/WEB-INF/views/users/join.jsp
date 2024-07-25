<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="<c:url value= "/javascript/users.js"/>">
    </script>
     <link rel="stylesheet" type="text/css" href="<c:url value='/css/users.css'/>">
</head>
<body>
    <!-- 회원가입 페이지: 사용자 이름과 비밀번호, 코드를 입력받습니다. 성공하면 회원가입에 성공했다는 알람과 함께 로그인 페이지(login.html)로 이동합니다.-->

    <form id="joinForm" action="<c:url value="/user/join"/>" method="post">
        <label for="name">사용자 아이디:</label>
        <input type="text" id="name" name="name" required><br>
       
        <input type="button" id="checkName"
			data-target="<c:url value="/user/checkName" />"
			value="이름 중복 체크" /><br>
		<input type="hidden" name="checkedName" value="n" /><br>
        
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br><br>
        
        <label for="code">지점 코드:</label>
        <input type="text" id="branchId" name="branchId" required><br><br>
        
        <button type="submit">회원가입</button>
    </form>

</body>
</html>