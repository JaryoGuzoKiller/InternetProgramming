<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 처리 페이지</title>
</head>
<body>
<%
	session.invalidate();
	response.sendRedirect("Home.jsp");
	//세션의 값을 없애고 메인 페이지로 제어를 이동한다.
%>

</body>
</html>