<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>윤혁의 숲</title>
<style>
body{
	background-color:#ffcccc;
}
body header{
	background-color:#ff66a3;
	width:100%;
	padding:10px;
	text-align:center;
	font-weight:bold;
	font-family:바탕;
	margin-top:0px;
}
header span{
	border:1px solid white;
	border-radius:20px;
	border-width:2px;
	padding:5px;
	font-size:22px;
	color:white;
}
header a{
	text-decoration:none;
}
section{/*가운데 게시물 출력 섹션 */
	background-color:white;
	
	width:43.8%;
	margin-left:auto;
	margin-right:auto;
	min-height:540px;
}
section div{
	
}
form>p{
	margin-left:10px;
	font-size:11px;
}
</style>
</head>
<body>
	<%
		String userId=null;
		if(session.getAttribute("userId")!=null){
			userId=(String)session.getAttribute("userId");
		}//로그인이 되어있다면 userId에 값을 할당, 아니면 null 상태
	%>
	<header>
		<a href="Home.jsp"><span>HyeokStargram~</span></a>
	</header>
	<section>
		<div>
			<p style="text-align:center;font-size:15px">글쓰기</p>
			<form action="Upload_do.jsp" enctype="multipart/form-data" method="post">	
				<p>아이디: <input type="text" id="userId"name="userId" value="<%=userId %>" readonly size="30"></p>
				<!-- 아이디는 사용자가 로그인한 아이디로 자동 설정된다 -->
				<p>제목: <input type="text" id="boardTitle"name="boardTitle" placeholder="제목을 입력하세요" size="30"></p>
				<p>내용:<br> 
					<textarea  rows="20"id="boardContent" name="boardContent"
					style="width:90%;overflow:scroll">
					</textarea>
				</p>
				<p>
				<input multiple="multiple" type="file"accept="image/jpg,image/gif,image/png" 
 				name="fileName" id="fileName">
 				</p><hr>
 				<p style="text-align:right;margin-right:10px;">
 				<input type="submit" value="저장하기">&nbsp;&nbsp;&nbsp;
 				<input type="button" value="취소하기" onClick="location.href='confirm2.jsp'">
 				</p>
			</form>
			
			
		</div>
	</section>
</body>
</html>