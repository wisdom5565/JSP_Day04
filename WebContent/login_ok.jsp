<%@page import="java.sql.*"%>
<%@page import="com.koreait.db.DBconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		conn = DBconn.getConnection();
		if(conn != null) {
			String sql = "SELECT mem_idx,mem_name FROM tb_member WHERE mem_userid = ? AND mem_userpw = sha2(?,256)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userpw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				session.setAttribute("userid", userid);
				session.setAttribute("idx", rs.getInt("mem_idx"));
				session.setAttribute("name", rs.getString("mem_name"));
				%> 
				<script>
				alert('로그인 성공!');
				location.href = "login.jsp"
				</script>
		<%
			} else {
		%>
				<script>
					alert('아이디 또는 비밀번호를 확인해주세요!');
					history.back();
				</script>
				<%
			}
			
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
	

%>
