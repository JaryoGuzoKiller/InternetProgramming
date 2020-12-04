<%@ page language="java" contentType="text/html; charset=UTF-8"
   import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
   import="java.sql.*, java.io.*"
%>
<%
request.setCharacterEncoding("utf-8");
Class.forName("org.mariadb.jdbc.Driver");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");
//upload 이름을 가지는 실제 서버의 경로명 알아내기

int maxsize = 5*1024*1024; //파일의 최대 크기 설정

MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, "utf-8", 
                     new DefaultFileRenamePolicy());
//multipartrequest 객체 생성

int boardId = Integer.parseInt(multi.getParameter("boardId"));
//사용자가 전달한 boardId값을 정수형으로 벼환
String userId = multi.getParameter("userId");
String boardTitle = multi.getParameter("boardTitle");
String boardContent = multi.getParameter("boardContent");
//사용자가 입력한 아이디,제목,게시물내용을 파라미터로 가져온다
String url = multi.getFilesystemName("url");
//파일 경로를 메소드를 통해 가져온다
String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
PreparedStatement pstmt = null;
String sql = null;
ResultSet rs = null;

if (url != null) { //새로운 파일을 선택할 때
   sql = "SELECT url FROM images WHERE boardId=?";
	//해당 boardId의 url을 조회
   pstmt = con.prepareStatement(sql);
   pstmt.setInt(1, boardId);
   rs = pstmt.executeQuery();
   
   if(rs.next()){//rs가 존재한다면
   
   String oldFileName = rs.getString("url");
   File oldFile = new File(realFolder + "\\" + oldFileName);
   //앞에서 알아낸 서버의 경로명과 파일명으로 파일 객체 생성
   oldFile.delete();
   //이전 파일 삭제
   }
   
   sql = "UPDATE board SET userId=?, boardTitle=?, boardContent=?,boardDate=NOW() WHERE boardId=?";
   //해당 게시물의 아이디,제목,내용을 수정하며 시간은 수정시간으로 최신화한다
   pstmt = con.prepareStatement(sql);
   pstmt.setString(1, userId);
   pstmt.setString(2, boardTitle);
   pstmt.setString(3, boardContent);  
   pstmt.setInt(4, boardId);
   
   
   PreparedStatement pstmt2 = null;
   ResultSet rs2 = null;
   String query="UPDATE images SET url=? WHERE boardId=?";
   //해당 게시물의 파일 경로를 수정한다
   pstmt2 = con.prepareStatement(query);
   pstmt2.setString(1, url);
   pstmt2.setInt(2, boardId);
   pstmt2.executeUpdate();
   
} else { //새로운 파일을 선택하지 않으면, 기존 파일명 유지
	 sql = "UPDATE board SET userId=?, boardTitle=?, boardContent=?,boardDate=NOW() WHERE boardId=?";
   pstmt = con.prepareStatement(sql);
   pstmt.setString(1, userId);
   pstmt.setString(2, boardTitle);
   pstmt.setString(3, boardContent);
   pstmt.setInt(4, boardId);
}
pstmt.executeUpdate();

if(pstmt!=null) pstmt.close();
if(rs!=null) rs.close();
if(con!=null) con.close();

response.sendRedirect("Home.jsp");//Home.jsp로 제어를 이동
%>