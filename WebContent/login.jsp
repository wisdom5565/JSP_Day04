<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = null;
	String name = null;

	if(session.getAttribute("userid") != null) {
		userid = (String)session.getAttribute("userid");
	}
	if(session.getAttribute("name") != null) {
		name = (String)session.getAttribute("name");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h2>로그인</h2>
<% if(userid == null) { %>
	<form method="post" action="login_ok.jsp"> 	
		<p>아이디 <input type="text" name="userid" id="userid"></p> 
		<p>비밀번호 <input type="password" name="userpw" id="userpw"></p>
		<p><button>로그인</button></p> 
	</form>
	<p><a href="member.jsp">아직 회원이 아니신가요?</a></p>
<% } else { %>

	<h3>👋<%= name %>님 환영합니다!👋</h3>
	<p><a href="logout.jsp"><button>로그아웃</button></a> | <a href = "info.jsp">정보수정</a> | <a href="./board/list.jsp">게시판</a></p>
<%} %>
</body>
</html>