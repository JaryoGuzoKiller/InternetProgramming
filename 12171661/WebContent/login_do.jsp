<%@ page contentType="text/html; charset=UTF-8"
    import="myBean.userDB"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 실행 페이지</title>
</head>
<body>
<jsp:useBean id="user" class="myBean.user" scope="page"/>
<jsp:setProperty property="*" name="user"/>
<%
	String userId=null;
	if(session.getAttribute("userId")!=null){
	userId=(String)session.getAttribute("userId");
	}//로그인이 되어있다면, userId에 값을 할당, 아니라면  null 상태
	if(userId!=null){ //로그인이 되어있다면 경고창과 함께 메인으로 이동시킨다
		out.println("<script>alert('이미 로그인이 되어있습니다.)");
		out.println("location.href='Home.jsp'");
		out.println("</script>");
	}
	userDB userdb=new userDB(); //userDB 클래스를 사용할 객체를 선언
	int result=userdb.login(user.getUserId(),user.getUserPwd());
	//아이디,패스워드를 파라미터로 하여 자바빈즈의 로그인 함수를 실행해 결과를 int형으로 반환
	if(result==1){//로그인 성공
		session.setAttribute("userId",user.getUserId());
		out.println("<script>location.href='Home.jsp'</script>");
	}else if(result==0){ //비밀번호 불일치
		out.println("<script>alert('비밀번호가 일치하지 않습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}else if(result==-1){//아이디 존재하지 않음
		out.println("<script>alert('존재하지 않는 아이디 입니다.')");
		out.println("history.back()");
		out.println("</script>");
	}else if(result ==-2){
		out.println("<script>alert('데이터베이스 오류발생.')");
		out.println("history.back()");
		out.println("</script>");
	}
%>
</body>
</html>