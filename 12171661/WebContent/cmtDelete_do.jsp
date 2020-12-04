<%@ page contentType="text/html;charset=UTF-8" language="java" 
	import="java.sql.*"%>

<%
    request.setCharacterEncoding("utf-8");

    String cmtIdx = request.getParameter("cmtIdx");
	//cmtIdx 파라미터 값을 받아온다
    Class.forName("org.mariadb.jdbc.Driver");
    Connection con=null;
    PreparedStatement pstmt=null;
    String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

   
    try {
        con = DriverManager.getConnection(DB_URL, "admin", "1234");
        
        String sql = "DELETE FROM cmt WHERE idx=?";
        //댓글 테이블에서 idx에 해당하는 댓글을 삭제하는 문장
       
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, cmtIdx);
        pstmt.executeUpdate();

        con.close();
        pstmt.close();

    } catch (SQLException e) { //sql예외처리
    	out.println(e.toString());
    }

    response.sendRedirect("Home.jsp");//제어를 Home.jsp로 이동
%>