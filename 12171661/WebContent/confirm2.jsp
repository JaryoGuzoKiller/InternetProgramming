<%@ page  contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소하시겠습니까?</title>
</head>
<body>
<script>
var confirm=confirm("수정을 중단 하시겠습니까?");
if(confirm){
	
	window.location.href="Home.jsp";
}else{
	window.history.back();
}
</script>

</body>
</html>