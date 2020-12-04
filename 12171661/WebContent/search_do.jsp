<%@ page contentType="text/html; charset=UTF-8"
   	 import="java.sql.*,myBoard.*"%>

<%
request.setCharacterEncoding("utf-8");
String search = request.getParameter("search");
//사용자가 입력한 검색어의 값을 파라미터로 알아낸다
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=search %> 검색결과</title>
<!-- 사용자의 검색어의 검색 결과를 보여주는 페이지 -->
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
}
section div{/*섹션 안에 상자간의 간격, 패딩 설정 */
	padding:0px;
	margin-top:7px;
}
.div1{/*맨 첫번째 상자(검색) 윗마진 설정 */
	padding:0px;
	margin-top:18px;
}
#new{
	font-size:12px;
	width:100%;
	height:30px;
	font-family:맑은고딕;
	border:1px solid white;
}
#search{
	font-size:12px;
	width:100%;
	height:30px;
	font-family:맑은고딕;
	border:1px solid white;
}

#index{ /*검색 돋보기 위치,크기설정 */
	position:absolute;
	right:353px;
	top:73px;
	width:55px;
	height:30px;
}

article{ /*게시물 차지하는 자리 높이 색상 설정 */
	width:100%;
	height:300px;
	background-color:white;
	font-size:11px;
	
}
article>header{/*게시물 상단 정보표시바 설정 */
	font-size:12px;
	text-align:left;
	padding:4px;
	width:90%;
	margin:auto;
}
header+div{/*게시글 글내용부분 설정 */
	padding:4px;
	text-align:left;
	margin:0px;
	height:60%;
	font-size:11px;
	width:90%;
	margin:auto;
}
.foot{/*게시글 하단 댓글,조회수,좋아요 설정 */
	padding:4px;
	text-align:left;
	margin:0px;
	font-size:11px;
	width:90%;
	margin:auto;
	height:8%;
	}
#login{/*로그인창 위치 크기 설정*/
	position:absolute;
	width:26%;
	top:70px;
	height:auto;
	margin-left:0px;
	background-color:#fff7cc;
}
.moreDisplay {text-decoration: none; }
.content {display:none;} 
#maindiv{
	margin-bottom:50px;
}
</style>
<script>
function moreDisplay(id){ //게시글 더보기를 구현하기 위한 자바스크립트 함수
	var obj=document.getElementById(id);
	if(obj.style.display=="none"|| obj.style.display==""){
		obj.style.display="block";
	}else{
		obj.style.display="none";
	}	
}
</script>
</head>
<body>
<jsp:useBean id="board" class="myBoard.board"/>
<jsp:useBean id="boardDB" class="myBoard.boardDB"/>
<%
	int count=0;
	if(session.getAttribute("count")!=null){
		count=((Integer)session.getAttribute("count")).intValue();
	}else{
		count=0;
	}
	count++;
	session.setAttribute("count", Integer.valueOf(count));
	//count변수에 게시물의 조회수를 할당한다
	String userId=null;
	if(session.getAttribute("userId")!=null){
		userId=(String)session.getAttribute("userId");
	}
	//로그인이 되어있다면, userId에 값을 할당, 안되어 있으면 null 상태
%>
	<header>
		<a href="Home.jsp"><span>HyeokStargram~</span></a>
	</header>
	<!-- 클릭하면, Home.jsp로 이동한다 -->
<%
	if(userId==null){ //로그인이 되어있지 않다면 로그인창을 띄운다
%>
	<div id="login">
	<form action="login_do.jsp" method="post">
	Member Login
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="Log in">
	&nbsp;&nbsp;
	<a href="join.jsp"><input type="button" value="Sign up"></a>
	<hr>
	
	User ID:<br>
	 <input type="text" name="userId"><br>
	Password:<br>
	 <input type="password" name="userPwd">
	</form>
	
	</div>
<%
} else{ //로그인이 되어있다면 해당 userId님 환영합니다 라는 문구와 함께 로그아웃 링크를 보여준다
%>
	<div id="login">
	<form action="logout_do.jsp" method="post">
	<%=userId %>님 환영합니다.
	<input type="submit" value="log out">
	</form>
	</div>
<%
}
%>
	<section>
		<div class="div1">
			<form action="search_do.jsp" method="get">
			<input type="text" id="search" name="search"placeholder="글 내용, 제목, 작성자 검색">
			<input type="submit" id="index"value="검색">
			</form>
			<!-- 제목,내용에 해당하는 게시물을 검색 할 수 있다 -->
		</div>
		<div>
		<a href="Upload.jsp"><input type="text" id="new"placeholder="새로운 소식을 남겨보세요."></a>
		</div>
		<!-- 빈칸을 클릭하면 게시물을 업로드하는 창으로 이동한다 -->
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
	try{
		con = DriverManager.getConnection(DB_URL,"admin","1234");
	    
		String sql = "SELECT * FROM board WHERE boardTitle like '%" + search + "%' or boardContent like '%" + search + "%'";
		//게시물 제목 또는 내용에서 사용자가 입력한 search 값을 포함하는 레코드를 조회한다
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();   
	    
	    while(rs.next()){ //레코드 커서를 이동
	    	
	    String query = "SELECT * FROM cmt WHERE boardId=?";
	    //게시물id에 해당하는 댓글을 검색한다
	    PreparedStatement pstmt2=con.prepareStatement(query);
	    pstmt2.setInt(1,rs.getInt("boardId"));
	    ResultSet rs2=pstmt2.executeQuery();
	       
	    rs2.last();
	    int rowCount = rs2.getRow(); 
	    rs2.beforeFirst();
	    //resultset 메소드를 이용해 왔다갔다 하면서 rowCount에 레코드의 개수를 넣어준다
%>
		<div id="maindiv">
			<article>
				<header>
					<p>제목: <%=rs.getString("boardTitle") %>&nbsp;&nbsp;&nbsp;
					작성자: <%=rs.getString("userId")%>&nbsp;&nbsp;&nbsp;
						작성일시: <%=rs.getString("boardDate") %>
					</p>
				</header>
				<div>
					<%
						if(rs.getString("boardContent").length()<99){
							//만약, 게시물의 내용이 100자 미만이라면
					%>
					<%=rs.getString("boardContent") %><br>
					<!-- 그대로 출력한다 -->
					<%
					}
					%>
					<%
						if(rs.getString("boardContent").length()>=99){
							//게시물 내용이 100자 이상이라면
					%>
					<%=rs.getString("boardContent").substring(0,99) %>
					<!-- 100자까지 내용을 보여준 후 더보기를 출력 -->
					<a class="moreDisplay" href="javascript:moreDisplay('myDiv1')">내용 더보기 &dArr;</a>
					<div id="myDiv1" class="content">
					<%=rs.getString("boardContent").substring(100,rs.getString("boardContent").length()) %>
					<!-- 더보기를 누르면 100자 이후의 게시글도 출력된다. -->
					</div>
					<%
						}
					%>
					<%
						String image_sql = "SELECT * FROM images WHERE boardId=?";
							//게시물에 해당하는 사진을 조회한다
						PreparedStatement image_pstmt = con.prepareStatement(image_sql);
						image_pstmt.setString(1, rs.getString("boardId"));
						ResultSet image_rs = image_pstmt.executeQuery();
						while (image_rs.next() && image_rs.getString("url") != null) {
							//이미지 레코드 커서를 이동하고 이미지가 존재한다면
					%>
					<a href="<%= "./upload/" + image_rs.getString("url") %>"><img src="<%= "./upload/" + image_rs.getString("url") %>"
						width="50" height="50"></a>
					<% //사진을 출력한다, 클릭하면 큰 사진이 보인다.
						}
					%>
				</div>

				<div class="foot">
					댓글 <%=rowCount %><img src="images/getout.jpg " alt="보기" style="width:12px;height:12px">&nbsp;&nbsp;&nbsp;조회 <%=count %>&nbsp;&nbsp;&nbsp;
					좋아요 <%=rs.getInt("likes") %>
					<%
						if((rs.getString("userId").equals(userId))){
							//로그인한 사용자와 게시물의 작성자가 일치한다면 수정,삭제 버튼을 보여준다
					%>
					<input type="button" value="수정" onClick="location.href='modify.jsp?boardId=<%=rs.getInt("boardId")%>'">&nbsp;&nbsp;&nbsp;
					<input type="button" value="삭제" onClick="location.href='confirm.jsp?boardId=<%=rs.getInt("boardId")%>'">
					<% //수정 or 삭제를 누르면 boardId와 함께 각각 해당 페이지로 이동한다. 수정은 수정하는 페이지, 삭제는 정말로 삭제하는지 여부를 물어보는 페이지로 이동한다.
						}
					%>
				</div>
				<div style="background-color:#ffe6e6;height:25px">
					<table style="padding:0px;width:100%;border:1px solid black;border-collapse:collpase">
						<tr>
							<th style="border-bottom:1px solid black" ><a href="like_do.jsp?boardId=<%=rs.getInt("boardId") %>">좋아요</a></th>
							<!-- 좋아요를 누르면 해당 게시물의 좋아요 숫자가 올라간다 -->
							<th style="border-bottom:1px solid black">댓글쓰기</th>
						</tr>
						<tr>
							<td style="margin-top:12px;text-align:left"colspan="2">
								<form action="comment_do.jsp?boardId=<%=rs.getInt("boardId") %>" method="post">
									<input type="text" id="comment" name="comment" size="65">
									&nbsp;&nbsp;<input type="submit" value="작성">
								</form>
								<!-- 댓글을 작성하면 boardId와 함께 comment_do.jsp가 실행된다 -->
							</td>
						</tr>
						<%
						while(rs2.next()){ //레코드 커서를 이동
						%>
						<tr>
							<td style="border-bottom:0.5px solid black;text-align:left"><%=rs2.getString("comment") %> 
							</td>
							<td style="font-size:8px;border-bottom:0.5px solid black;text-align:right">by <%=rs2.getString("userId") %> 작성시간: <%=rs2.getString("commentDate")%>
							<% //댓글과 작성시간을 rs2값으로 받아와 출력한다.
								if((rs2.getString("userId").equals(userId))){
									//댓글작성자와 로그인한 사람이 일치하면 수정,삭제 버튼을 띄운다
							%>
							<a href="cmtModify.jsp?cmtIdx=<%=rs2.getString("idx") %>">수정</a> <a href="cmtDelete_do.jsp?cmtIdx=<%=rs2.getString("idx") %>">삭제</a>
							<%
								}
							%>
							</td>
						</tr>
						<%
						}
						%>
					</table>
					<%
	  					  }
					%>
				</div>
				
			</article>
		</div>
<% 
	    
	    rs.close();
	    pstmt.close();
	    con.close();
	}catch (SQLException e) {//sql 예외처리
	      out.println(e.toString());
	      return;
	} 
	    
%>
	</section>
		
</body>
</html>