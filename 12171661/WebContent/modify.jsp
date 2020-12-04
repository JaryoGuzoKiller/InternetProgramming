<%@ page contentType="text/html; charset=UTF-8"
	import="java.io.*,myBoard.*,java.sql.*,myBoard.boardDB"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
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
	
	int boardId = Integer.parseInt(request.getParameter("boardId"));
	//사용자가 전달한 boardId값을 파라미터로 가져와 정수형으로 변환
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?userSSL=false";

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	con = DriverManager.getConnection(DB_URL, "admin", "1234");
	String sql = "SELECT userId,boardTitle,boardContent FROM board WHERE boardId=?";
	//board 테이블에서 해당하는 게시물의 아이디,제목,내용을 가져온다
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, boardId);
	rs = pstmt.executeQuery();
	rs.next();//레코드 커서를 이동
	
	PreparedStatement pstmt2=null;
	ResultSet rs2=null;
	
	String query="SELECT url FROM images WHERE boardId=?";
	//boardId에 해당하는 사진 url을 가져온다
	pstmt2 = con.prepareStatement(query);
	pstmt2.setInt(1, boardId);
	rs2 = pstmt2.executeQuery();
	
%>
	<header>
		<a href="Home.jsp"><span>hyeokStargram~</span></a>
	</header>
	<section>
		<div>
			<p style="text-align:center;font-size:15px">글쓰기</p>
			<form action="modify_do.jsp?boardId=<%=boardId %>" enctype="multipart/form-data" method="post">		
				<p>아이디: <input type="text" id="userId"name="userId" placeholder="아이디을 입력하세요" size="30"
				readonly value="<%=rs.getString("userId")%>"></p>
				<p>제목: <input type="text" id="boardTitle"name="boardTitle" placeholder="제목을 입력하세요" size="30"
						value="<%=rs.getString("boardTitle")%>"></p>
				<p>내용:<br> 
					<textarea  rows="20"id="boardContent" name="boardContent"
					style="width:90%;overflow:scroll"><%=rs.getString("boardContent")%>
					</textarea>
				</p>
				<%	//수정하기 전, 기존에 본인이 입력한 내용을 확인하고 수정할 수 있다.
					if(rs2.next()){ //rs2가 존재한다면
				%>
				<p>
				기존 파일명: <%=rs2.getString("url") %> 
				<img src="./upload/<%=rs2.getString("url") %>" width="50" height="50">
				</p> 
				<%
					}
				%>
				<p>
				변경할 사진: <input multiple="multiple" type="file"accept="image/jpg,image/gif,image/png" 
 				name="url" id="url">
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