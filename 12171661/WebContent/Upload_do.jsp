<%@ page  contentType="text/html; charset=UTF-8"
		import="myBoard.boardDB,java.io.*,com.oreilly.servlet.*,
		com.oreilly.servlet.multipart.*" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 실행</title>
</head>
<body>
<jsp:useBean id="board" class="myBoard.board" scope="page"/>
<jsp:setProperty name="board" property="*" />
<%
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String)session.getAttribute("userId");
	}//로그인이 되어있다면 userId에 값을 할당하고 아니면 null 상태

	if (userId == null) { //비로그인 상태이면
		out.println("<script>alert('로그인을 하세요.')");
		out.println("location.href='Home.jsp'</script>");
	} else {
		String uploadPath = request.getServletContext().getRealPath("upload");
		//upload 이름을 가지는 실제 서버의 경로명 알아내기
		File uploadDir = new File(uploadPath);
		//알아낸 서버의 경로명과 파일명으로 파일 객체 생성
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		//존재하지 않을 경우, 디렉토리를 생성해준다
		int maxSize = 5*1024*1024;
		//최대 전송 파일 크기 설정
		String encoding = "UTF-8";
		MultipartRequest multipartRequest = new MultipartRequest(
				request,uploadPath,maxSize,encoding,new DefaultFileRenamePolicy()
		);
		//multipartrequest 객체 생성
		String ReqUserId = userId;
		String ReqTitle = multipartRequest.getParameter("boardTitle");
		String ReqContent = multipartRequest.getParameter("boardContent");
		//사용자가 입력한 값을 파라미터로 받아옴
		File uploadFile = multipartRequest.getFile("fileName");
		String OriginFileName = multipartRequest.getOriginalFileName("fileName");
		String FSName = multipartRequest.getFilesystemName("fileName");
		//mutipartrequest 메소드를 이용해 각각의 경로명을 가져옴
		if (ReqTitle.length() == 0 || ReqContent.length() == 0) {
			//입력이 안된 사항이 있으면 파일을 삭제하고 전페이지로 돌아간다.
			File Obj = new File(uploadPath + "/" + FSName);
			if (Obj.exists()) {
				Obj.delete();
			}

			out.println("<script>alert('입력이 안 된 사항이 있습니다.')");
			out.println("history.back()</script>");
		}
		boardDB boarddb = new boardDB();//boardDB 클래스 이용을 위한 객체생성
		int result = boarddb.write(ReqTitle, ReqUserId, ReqContent);
		//boardDB.write에서 게시물제목,아이디,내용을 파라미터로 하여 정수값을 반환
		int boardId = boarddb.getRecentBoardIdx(ReqUserId);

		int resultOfSaveImage = boarddb.saveImagePath(boardId, FSName);
		//boardDB.saveImagePath에서 db에 게시물 아이디와 경로를 같이 저장한다
		
		if (result == -1) { //실행되지 않는다면
			out.println("<script>alert('글쓰기에 실패함')");
			out.println("history.back()</script>");
		} else { //정상적으로 실행된다면
			out.println("<script>alert('글쓰기 성공')");
			out.println("location.href='Home.jsp'</script>");
		}
	}
%>
</body>
</html>