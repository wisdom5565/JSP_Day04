<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	
	String b_title = request.getParameter("b_title");
	String b_content = request.getParameter("b_content");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		conn = DBconn.getConnection();
		if(conn != null){
			String sql = "INSERT INTO tb_board (b_userid, b_name, b_title, b_content) VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1,userid);
			pstmt.setString(2,name);
			pstmt.setString(3,b_title);
			pstmt.setString(4,b_content);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt >= 1) {
%> 
			<script> 
				alert('글 등록 완료!');
				location.href="list.jsp";
			</script>

<%
			} else {	
%>
			<script>
				alert('글 등록 실패..!')
				history.back();
			</script>
<%
			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	}

%>