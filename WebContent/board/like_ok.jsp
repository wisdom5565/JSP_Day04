<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	String b_idx = request.getParameter("b_idx");
	String userid = request.getParameter("userid");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		conn = DBconn.getConnection();
		
		if(conn != null) {
			int b_like = 0;
			
			String sql = "SELECT li_idx FROM tb_like WHERE li_boardidx = ? AND li_userid";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,b_idx);
			pstmt.setString(2, userid);	
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql =  "UPDATE tb_board SET b_like = b_like - 1 WHERE b_idx";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.executeUpdate();
				
				sql = "DELETE FROM tb_like WHERE li_boardidx = ? AND li_userid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				pstmt.setString(2,userid);
				pstmt.executeUpdate();
			} else {
				sql = "UPDATE tb_board SET b_like = b_like + 1 WHERE b_idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.executeUpdate();
				
				sql ="INSERT INTO tb_like (li_boardidx, li_userid) VALUES (?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				pstmt.setString(2,userid);
				pstmt.executeUpdate();
			}
			sql = "SELECT b_like FROM tb_board WHERE b_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,b_idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b_like =  rs.getInt("b_like");
				out.print(b_like);
			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>