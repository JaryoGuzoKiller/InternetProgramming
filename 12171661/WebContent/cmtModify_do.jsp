

<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="java.sql.*" %>
<%
    request.setCharacterEncoding("utf-8");

    String cmtIdx = request.getParameter("cmtIdx");
    //cmtIdx값을 파라미터로 받아온다
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
        Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");

        String sql = "UPDATE cmt SET comment=? WHERE idx=?";
        //해당 idx에 댓글을 수정하는 문장
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, request.getParameter("comment"));
        //입력한 댓글로 수정한다
        pstmt.setString(2, cmtIdx);
        pstmt.executeUpdate();

        pstmt.close();
        con.close();
    } catch (SQLException e) {//예외처리
    	out.println(e.toString());
        return;
    }

    response.sendRedirect("Home.jsp");//제어를 Home.jsp로 이동
%>