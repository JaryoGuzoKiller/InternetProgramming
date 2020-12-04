<%@ page  contentType="text/html; charset=UTF-8"
   import="myBean.userDB" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 실행중</title>
</head>
<body>
<jsp:useBean id="user" class="myBean.user" scope="page" />
<jsp:setProperty name="user" property="*" />
<%
	String userId=null;
	if(session.getAttribute("userId")!=null){
		userId=(String)session.getAttribute("userId");
	}//로그인이 되어있다면 userId에 값을 할당하고 아니라면 null 상태
	
	if(user.getUserId() == null||user.getUserPwd() == null){ //아이디,패스워드 중 하나라도 입력하지 않으면 전페이지로 이동한다.
		out.println("<script>alert('입력이 안 된 사항이 있습니다.')");
		out.println("history.back()</script>");
	}else{
		userDB userdb=new userDB();//userDB 클래스를 이용하는 객체를 선언
		int result=userdb.join(user);
		//userDB의 회원가입 함수에 user를 파라미터로 넘겨 실행
		
		if(result==-1){
			out.println("<script>alert('아이디 중복입니다.')");
			out.println("history.back()</script>");
		}else{
			out.println("<script>alert('성공적으로 가입됨')");
			out.println("location.href='Home.jsp'</script>");
		}
	}

%>
</body>
</html>