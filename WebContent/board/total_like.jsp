<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="com.koreait.db.DBconn"%>
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
			sql = "UPDATE tb_board SET b_like = b_like + 1 WHERE b_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			cnt = pstmt.executeUpdate();
			System.out.println("증가 업데이트 완료");
			
			if(cnt >= 1) {
				sql ="INSERT INTO tb_like (li_boardidx, li_userid) VALUES (?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				pstmt.setString(2,userid);
				pstmt.executeUpdate();
				System.out.println("tb_like 추가 완료");

				sql = "SELECT b_like FROM tb_board WHERE b_idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,b_idx);
				rs= pstmt.executeQuery();
				System.out.println("b_like 가져오기 완료");
				if(rs.next()) {
					String b_like = rs.getString("b_like");
					out.print(b_like + "&nbsp<img onClick = 'delLike()' style ='width:26px; height:26px;'src='./heart_on.png'>");
				}
				
			
			}
		}
	} catch(Exception e) {
		e.printStackTrace();
	}


%>