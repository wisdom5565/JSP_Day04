<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String b_idx = request.getParameter("b_idx");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String b_title = "";
	String b_content = "";
	
	try{
		conn = DBconn.getConnection();
		if(conn != null) {
			String sql =  "SELECT b_title, b_content FROM tb_board WHERE b_idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b_title = rs.getString("b_title");
				b_content = rs.getString("b_content");
			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글수정</title>
</head>
<body>
	<h2>글수정</h2>
	<form method ="post" action="edit_ok.jsp"><%-- ?b_idx=<%=b_idx%>" --%>
	 	<input type ="hidden" name="b_idx" value="<%=b_idx %>">		<!--이게 좋은 방법  -->
		<p>작성자 : <%=name %>(<%=userid %>)</p>
		<p>제목 <input type ="text" name="b_title" value = "<%=b_title%>">
		<p>내용</p>
		<p><textarea style = "width:300px; height: 200px; resize:none;" name="b_content"><%=b_content %></textarea></p>
		<p><button>수정</button> | <button type ="reset">재작성</button> | 
		<button type ="button" onClick="history.back();">뒤로 돌아가기</button></p> 
	
	</form>
</body>
</html>