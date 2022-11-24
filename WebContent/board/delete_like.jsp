<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String b_idx = request.getParameter("b_idx");
	String userid = request.getParameter("userid");
	int cnt = 0;
	String sql ="";
	
	try {
		conn = DBconn.getConnection();
		if(conn !=null) {
			sql = "UPDATE tb_board SET b_like = b_like - 1 WHERE b_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			cnt = pstmt.executeUpdate();
			System.out.println("감소 업데이트 완료");
			
			if(cnt >= 1) {
				sql ="DELETE FROM tb_like WHERE li_boardidx = ? AND li_userid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				pstmt.setString(2,userid);
				pstmt.executeUpdate();
				System.out.println("tb_like 삭제 완료");

				sql = "SELECT b_like FROM tb_board WHERE b_idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				rs= pstmt.executeQuery();
				System.out.println("b_like갯수 검색 완료");
				if(rs.next()) {
					String b_like = rs.getString("b_like");
					out.print(b_like+"&nbsp<img onClick = 'plusLike()' style ='width:25px; height:25px;'src='./heart_off.png'>");
				}

			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	}

%>