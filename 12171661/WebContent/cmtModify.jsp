<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>댓글 수정 페이지</title>
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
	String cmtIdx = request.getParameter("cmtIdx");
	//cmtIdx값을 파라미터로 받아온다
	if(session.getAttribute("userId")!=null){
		userId=(String)session.getAttribute("userId");
	}
	//로그인이 되어있다면, userId에 로그인 id를 넣는다.
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

	try{
		con = DriverManager.getConnection(DB_URL,"admin","1234");

		String sql = "SELECT * FROM cmt WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, cmtIdx);
		rs = pstmt.executeQuery();
		rs.next();
		con.close();
%>
<header>
	<a href="Home.jsp"><span>hyeokStargram~</span></a>
</header>
<section>
	<div>
		<p style="text-align:center;font-size:15px">댓글 수정</p>
		<form action="cmtModify_do.jsp?cmtIdx=<%=cmtIdx%>" method="post">
			<p>아이디: <input type="text" id="userId" name="userId" value="<%=userId %>" readonly size="30"></p>
			<p>댓글: <input type="text" id="comment" name="comment" value="<%=rs.getString("comment")%>" size="30"></p>


			<p style="text-align:right;margin-right:10px;">
				<input type="submit" value="수정하기">&nbsp;&nbsp;&nbsp;
				<input type="button" value="취소하기" onClick="location.href='confirm2.jsp'">
			</p>
		</form>
	</div>
</section>
</body>
</html>
<%
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>