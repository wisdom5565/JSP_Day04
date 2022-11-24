<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String b_idx = request.getParameter("b_idx");
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	
	String b_title =  request.getParameter("b_title");
	String b_content =  request.getParameter("b_content");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	int cnt = 0;
	
	try {
		conn = DBconn.getConnection();
		if(conn != null) {
			String sql = "UPDATE tb_board SET b_title = ? , b_content = ? WHERE b_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_title);
			pstmt.setString(2, b_content);
			pstmt.setString(3, b_idx);
			
			cnt = pstmt.executeUpdate();
			if(cnt >= 1) {
%>
		<script>
			alert("글 수정 완료!");
			location.href = "view.jsp?b_idx=<%=b_idx%>";
		</script>
<%

			} else { 
%>
		<script>
			alert("글 수정 실패...")
			history.back();
		</script>

<%
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>