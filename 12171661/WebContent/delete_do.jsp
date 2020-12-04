<%@ page contentType="text/html;charset=utf-8"
	 import="java.sql.*, java.io.*" %>
<%
request.setCharacterEncoding("utf-8");
 
try {
	String boardId = request.getParameter("boardId");
 	//파라미터로 boardId 값을 받아옴
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	String sql = "SELECT url FROM images WHERE boardId=?";
	//boardId에 해당하는 사진의 경로를 검색
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(boardId));
	//string으로 받아왔으므로 integer로 형변환을 시켜준다
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
	//만약. rs에 값이 존재한다면
	String url = rs.getString("url");
	//url필드의 값을 알아낸다
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	//upload 경로이름을 가지는 실제 서버의 경로명 알아내기
	File file = new File(realFolder + "\\" + url);
	//알아낸 경로명과 파일명으로 파일 객체 생성
	file.delete();
	//파일 삭제
	}
	sql = "DELETE FROM board WHERE boardId=?";
	//boardId에 해당하는 레코드를 삭제한다
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(boardId));
	//string으로 받아왔으므로 integer로 형변환을 시켜준다
	pstmt.executeUpdate();
	
	rs.close();
	pstmt.close();
	con.close();
}  catch (SQLException e) {
	out.println(e.toString());
	return;
} 
catch (Exception e) { 
	out.println(e.toString());
	return;
}

response.sendRedirect("Home.jsp"); //제어를 Home.jsp로 이동  
%> 