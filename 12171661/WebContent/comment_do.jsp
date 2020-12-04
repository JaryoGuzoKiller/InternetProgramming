<%@ page contentType="text/html;charset=utf-8" import="java.sql.*, java.io.*" %>
<%
request.setCharacterEncoding("utf-8");
String userId = null;
if (session.getAttribute("userId") != null) {
	userId = (String)session.getAttribute("userId");
}//로그인이 되어있다면 userId에 값을 할당하고 아니면 null 상태

if (userId == null) { //비로그인 상태이면
	out.println("<script>alert('로그인을 하세요.')");
	out.println("location.href='Home.jsp'</script>");
} else {

Connection con =null;
PreparedStatement pstmt = null;
ResultSet rs = null;

int boardId = Integer.parseInt(request.getParameter("boardId"));
//boardId값을 파라미터로 전달받는다
String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

Class.forName("org.mariadb.jdbc.Driver");
con=DriverManager.getConnection(DB_URL, "admin", "1234");
String sql="INSERT INTO cmt(boardId, comment,userId) VALUES(?,?,?)";
//댓글 테이블에 해당 boardId와 댓글내용,작성자 아이디,작성일시를 삽입한다
pstmt=con.prepareStatement(sql);
pstmt.setInt(1,boardId);
pstmt.setString(2,request.getParameter("comment"));
pstmt.setString(3,userId);
//파라미터로 입력한 댓글내용과 작성자를 가져온다
pstmt.executeUpdate();

response.sendRedirect("Home.jsp");//제어를 Home.jsp로 이동
}
%>