<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ include file ="./include/sessionCheck.jsp" %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	request.setCharacterEncoding("UTF-8");
	String userid = (String)session.getAttribute("userid");
	int cnt = 0;

	String userpw = request.getParameter("userpw");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	String[] hobby = request.getParameterValues("hobby");
	String ssn1 = request.getParameter("ssn1");
	String ssn2 = request.getParameter("ssn2");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");

	String sql = "";
	try {
		conn = DBconn.getConnection();
		
		if(conn != null) {
			sql =  "SELECT mem_idx FROM tb_member WHERE mem_userid = ? AND mem_userpw = sha2(?,256)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			pstmt.setString(2,userpw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "UPDATE tb_member SET mem_name = ?, mem_hp = ?, mem_email = ?, mem_gender = ?, mem_hobby = ?, mem_ssn1 = ?, mem_ssn2=?, mem_zipcode = ?, mem_address1 = ?, mem_address2 = ?, mem_address3 = ? WHERE mem_userid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, hp);
				pstmt.setString(3, email);
				pstmt.setString(4, gender);
				String hobbyStr = "";
				for(int i = 0; i < hobby.length; i++) {
					hobbyStr = hobbyStr+hobby[i]+ " "; 
				}
				pstmt.setString(5, hobbyStr);
				pstmt.setString(6, ssn1);
				pstmt.setString(7, ssn2);
				pstmt.setString(8, zipcode);
				pstmt.setString(9, address1);
				pstmt.setString(10, address2);
				pstmt.setString(11, address3);
				pstmt.setString(12, userid);
				
				cnt = pstmt.executeUpdate();
				if(cnt >= 1) {
	%>
				<script>
					alert('정보수정완료!');
					location.href ="login.jsp";
				</script>
	<%			} else {	%>
				<script>
					alert('정보 수정 실패!');
					history.back();
				</script>		
	<%	
				}
				
			} else {
	%>
				<script>
					alert('비밀번호를 다시 확인해주세요!');
					history.back();
				</script>
		<%				
			}
			
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>