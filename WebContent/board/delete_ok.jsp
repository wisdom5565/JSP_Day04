<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String b_idx = request.getParameter("b_idx");
	String userid = (String)session.getAttribute("userid");

	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		conn = DBconn.getConnection();
		
		if(conn != null) {
			String sql =  "DELETE FROM tb_board WHERE b_idx = ? AND b_userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			pstmt.setString(2,userid);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt >= 1) {
%>
			<script>
				alert('글 삭제 완료!');
				location.href="list.jsp"
			</script>

<%
			} else {
%>
			<script>
				alert('글 삭제 실패..');
				history.back();
			</script>

<%				
			}
		}
	} catch (Exception e) {	
		e.printStackTrace();
	}

%>