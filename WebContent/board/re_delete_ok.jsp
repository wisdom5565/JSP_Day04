<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String userid =  (String)session.getAttribute("userid");
	String re_idx = request.getParameter("re_idx");
	String b_idx = request.getParameter("b_idx");
	
	Connection conn =null;
	PreparedStatement pstmt = null;
	
	try {
		conn = DBconn.getConnection();
		
		if(conn !=  null) {
			String sql =  "DELETE FROM tb_reply WHERE re_idx = ? AND re_userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,re_idx);
			pstmt.setString(2, userid);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt >= 1) {
%>
				<script>
					alert('댓글 삭제 완료!')
					location.href = "view.jsp?b_idx="+<%=b_idx%>;
				</script>
<%
			} else { 
%>
				<script>
					alert('댓글 삭제 실패..');
					history.back();
				</script>			
<%	
			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>