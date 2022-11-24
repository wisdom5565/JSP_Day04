<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	String b_idx = request.getParameter("b_idx");
	String b_title = "";
	String b_userid = "";
	String b_name = "";
	int b_like = 0;
	int b_hit = 0;
	String b_regdate = "";
	String b_content = "";
	String re_name = "";
	String re_userid = "";
	String re_content = "";
	String re_regdate = "";
	String re_idx = "";
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	try {
		conn = DBconn.getConnection();
		if(conn != null) {
			 sql = "UPDATE tb_board SET b_hit = b_hit + 1 WHERE b_idx = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1,b_idx);
			 int cnt = pstmt.executeUpdate();
			 
			 if(cnt >= 1) {
				sql = "SELECT * FROM tb_board WHERE b_idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					b_title = rs.getString("b_title");
					b_userid = rs.getString("b_userid");
					b_name = rs.getString("b_name");
					b_hit = rs.getInt("b_hit");
					b_like = rs.getInt("b_like");
					b_regdate = rs.getString("b_regdate");
					b_content = rs.getString("b_content");
				}
			 } 
			 sql = "SELECT re_idx, re_userid, re_name, re_content, re_regdate FROM tb_reply WHERE re_boardidx = ? ORDER BY re_idx asc";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1,b_idx);
			 rs = pstmt.executeQuery();
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
</head>
<style>
	table {
		width : 800px;
		border : 1px solid black;
		border-collapse: collapse;
		margin : 0 auto;
	}
	
	th,td {
		border : 1px solid black;
		padding : 10px;
		text-align : center;
	}
	hr {
		width: 800px;
	}
	body {
		text-align : center;
		
	}
</style>
<script>
	function del(b_idx) {
		//alert(b_idx);
		const yn = confirm('글을 삭제하시겠습니까?');
		if(yn) location.href = "../Delete?b_idx="+b_idx;
	}
	
	function delReply(re_idx,b_idx) {
/* 		alert(re_idx);
		alert(b_idx); */
	 	const yn = confirm ('댓글을 삭제하시겠습니까?');
		if(yn) location.href="../ReDelete?re_idx="+re_idx+"&b_idx="+b_idx; 
	}
</script>
<body>
	<h2>글보기</h2>
	<table>
		<tr>
			<th>제목</th>
			<td><%=b_title %></td>
		</tr>
		<tr>
			<th>날짜</th>
			<td><%=b_regdate %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= b_name %>(<%= b_userid %>)</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%= b_hit %></td>
		</tr>
		<tr>
			<th>좋아요</th>
			<td id="likeCnt"><%= b_like %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%= b_content %></td>
		</tr>
		<tr>
			<td colspan="2">
<%
		if(b_userid.equals(userid)) {
			
%>
			
			<input type="button" value="수정" onClick="location.href='1_edit.jsp?b_idx=<%=b_idx%>'">
	<!--    <input type ="button" value="삭제" onClick="location.href='delete_ok.jsp?b_idx='">-->
			<input type ="button" value="삭제" onClick="del('<%=b_idx %>')">
<%
		} 
%>
			<input type ="button" onClick = "location.href = 'list.jsp'" value="리스트">
			<input type ="button" value ="좋아요" onClick="clickLike()" >
			</td>
		</tr>
	</table>
	<hr>
	<form method ="post" action="../ReWrite">
		<input type="hidden" name = "b_idx" value = "<%=b_idx %>">
		<p><%=userid%>(<%=name %>) : <input type ="text" name ="re_content"> <button>확인</button></p>
	</form>
	<hr>
<% 
	while(rs.next()) {
		 re_idx = rs.getString("re_idx");
		 re_name = rs.getString("re_name");
		 re_userid = rs.getString("re_userid");
		 re_content = rs.getString("re_content");
		 re_regdate = rs.getString("re_regdate");
%>
	<p>💡 <b><%=re_name%></b> (<%=re_userid %>) :  <%=re_content %> (<%=re_regdate %>)
<% 
	if(re_userid.equals(userid)){
%>
	<button type="button" onClick = "delReply('<%=re_idx%>','<%=b_idx%>')">삭제</button></p>

<%
	}
}
%>
<script>
	function clickLike() {
		const xhr = new XMLHttpRequest();
		xhr.open('get', 'like.jsp?b_idx=<%=b_idx %>', true);
		xhr.send();
		xhr.onreadystatechange = function() {
				if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
				const result = xhr.responseText.trim();
				console.log(result);
				document.getElementById('likeCnt').innerHTML = result;
			
			}
		}
	}
</script>
</body>
</html>