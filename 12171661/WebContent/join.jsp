<%@ page contentType="text/html; charset=UTF-8"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
body{/*전체 배경색 분홍*/
	background-color:#ffcccc;
}
body >header{/*사이트 제목부분 배경,크기 설정 */
	background-color:#ff66a3;
	width:100%;
	padding:10px;
	text-align:center;
	font-weight:bold;
	font-family:바탕;
	
}
header span{/*사이트 제목부분 border설정 */
	border:1px solid white;
	border-radius:20px;
	border-width:2px;
	padding:5px;
	font-size:22px;
	color:white;
}
header a{/*사이트 제목 밑줄 없애기 */
	text-decoration:none;
}
section{/*가운데 게시물 출력 섹션 */
	text-align:center;
	width:43.8%;
	margin-left:auto;
	margin-right:auto;
	min-height:540px;
	background-color:white;
}

input[type=text]{
	margin:10px;
	width:70%;
	height:20px;
}
</style>
<script>
function back(){
	window.history.back();
}//페이지 뒤로가기
</script>
</head>
<body>
	<header>
		<a href="Home.jsp"><span>HyeokStargram~</span></a>
	</header>
	<section>
	<div>
		<form action="join_do.jsp" method="post">
			<input type="text" name="userId" placeholder="아이디"><br>
			<input type="text" name="userPwd" placeholder="패스워드"><br><br>
			<input type="submit" value="회원가입">&nbsp;&nbsp;&nbsp;
			 <input type="button" value="뒤로가기" onclick="back();">
		</form>
		<!-- 이름,아이디,패스워드를 입력해 회원가입을 할 수 있는 폼 -->
	</div>
		
	</section>
		
</body>
</html>