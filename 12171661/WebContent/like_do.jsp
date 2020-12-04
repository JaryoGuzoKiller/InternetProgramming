<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="java.sql.*, java.io.*"
%>
<%
request.setCharacterEncoding("utf-8");

Connection con =null;
PreparedStatement pstmt = null;
ResultSet rs = null;

int boardId = Integer.parseInt(request.getParameter("boardId"));
//boardId를 파라미터를 이용해 정수형으로 변환해 받아옴
String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

Class.forName("org.mariadb.jdbc.Driver");
con=DriverManager.getConnection(DB_URL, "admin", "1234");
String sql="UPDATE board SET likes=likes+1 WHERE boardId=?";
//해당 게시물의 좋아요 수를 1씩 증가시킨다
pstmt=con.prepareStatement(sql);
pstmt.setInt(1,boardId);
pstmt.executeUpdate();

response.sendRedirect("Home.jsp");//제어를 Home.jsp로 이동
%>