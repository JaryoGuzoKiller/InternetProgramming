<%@ page  contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int boardId = Integer.parseInt(request.getParameter("boardId"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제하시겠습니까?</title>
</head>
<body>
<script>
var confirm=confirm("정말로 삭제 하시겠습니까?");
if(confirm){
	alert('삭제되었습니다.');
	window.location.href="delete_do.jsp?boardId=<%=boardId%>";
	//삭제한다면, delete_do페이지로 boardId 파라미터값과 함께 이동
}else{
	window.location.href='Home.jsp';
}
</script>

</body>
</html>