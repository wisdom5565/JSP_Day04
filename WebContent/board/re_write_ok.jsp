<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String userid = (String)session.getAttribute("userid");	
	String name = (String)session.getAttribute("name");
	String re_content = request.getParameter("re_content");
	String b_idx = request.getParameter("b_idx");
	
	Connection conn =null;
	PreparedStatement pstmt = null;
	
	try {
		conn = DBconn.getConnection();
		
		if(conn != null) {
			String sql = "INSERT INTO tb_reply (re_userid, re_name, re_content, re_boardidx) VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, name);
			pstmt.setString(3, re_content);
			pstmt.setString(4, b_idx);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt >= 1) {
%>
			<script>
				alert('댓글 입력 완료!');
				location.href = "view.jsp?b_idx="+<%=b_idx%>;
			</script>		
			
<% 
			} else {
%>
			<script>
				alert('댓글 입력 실패...');
				history.back();
			</script>
<%
			}
		}
	}catch(Exception e) {
		e.printStackTrace();
	}

%>
