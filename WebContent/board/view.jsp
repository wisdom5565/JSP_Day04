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
	String li_userid = "";
	int cnt = 0;
	String userid = (String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	try {
		conn = DBconn.getConnection();
		if(conn != null) {
			 sql = "SELECT hit_idx FROM tb_hit WHERE hit_boardidx = ? AND hit_userid=?"; 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1,b_idx);
			 pstmt.setString(2,userid);
			 rs = pstmt.executeQuery();
			 if(!rs.next()){
				 // 조회수 증가 
				 sql = "UPDATE tb_board SET b_hit = b_hit + 1 WHERE b_idx = ?";
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1,b_idx);
				 cnt = pstmt.executeUpdate();
				 
				sql  ="INSERT INTO tb_hit (hit_boardidx, hit_userid) VALUES (?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.setString(2,userid);
				pstmt.executeUpdate();
			 }
				 // 글 상세 정보 갖고오기
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
			 // 댓글 정보 갖고오기
			 sql = "SELECT re_idx, re_userid, re_name, re_content, re_regdate FROM tb_reply WHERE re_boardidx = ? ORDER BY re_idx asc";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1,b_idx);
			 rs = pstmt.executeQuery();
			 
			 // 좋아요 갯수
			 sql = "SELECT li_userid FROM tb_like WHERE li_boardidx = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1,b_idx);
			 ResultSet rs_like = pstmt.executeQuery();
			 if(rs_like.next()) {
				li_userid = rs_like.getString("li_userid");
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
	
	img {
		width : 20px;
		height : 20px;
	}
</style>
<script>
	// 글삭제 함수
	function del(b_idx) {
		//alert(b_idx);
		const yn = confirm('글을 삭제하시겠습니까?');
		if(yn) location.href = "delete_ok.jsp?b_idx="+b_idx;
	}
	
	// 댓글 삭제 함수
	function delReply(re_idx,b_idx) {
/* 		alert(re_idx);
		alert(b_idx); */
	 	const yn = confirm ('댓글을 삭제하시겠습니까?');
		if(yn) location.href="re_delete_ok.jsp?re_idx="+re_idx+"&b_idx="+b_idx; 
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
			<td id = "likeCnt">
			<%= b_like %>
			<% if(userid.equals(li_userid)) { %>
				<img onClick = 'delLike()' style ='width:26px; height:26px;'src='./heart_on.png'>
			<% } else { %>
				<img onClick = 'plusLike()' style ='width:25px; height:25px;'src='./heart_off.png'>
			<%}%>
		</td>
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
			
			<input type="button" value="수정" onClick="location.href='edit.jsp?b_idx=<%=b_idx%>'">
	<!--    <input type ="button" value="삭제" onClick="location.href='delete_ok.jsp?b_idx='">-->
			<input type ="button" value="삭제" onClick="del('<%=b_idx %>')">
<%
		} 
%>
			<input type ="button" onClick = "location.href = 'list.jsp'" value="리스트">
			<!-- <input type ="button" value ="좋아요" onClick="plusLike()" >  -->
			</td>
		</tr>
	</table>
	<hr>
	<!-- 댓글 작성  -->
	<form method ="post" action="re_write_ok.jsp">
		<input type="hidden" name = "b_idx" value = "<%=b_idx %>">
		<p><%=userid%>(<%=name %>) : <input type ="text" name ="re_content"> <button>확인</button></p>
	</form>
	<hr>
<% 
	// 댓글 갖고오기
	while(rs.next()) {
		 re_idx = rs.getString("re_idx");
		 re_name = rs.getString("re_name");
		 re_userid = rs.getString("re_userid");
		 re_content = rs.getString("re_content");
		 re_regdate = rs.getString("re_regdate");
%>
	<p>👉🏻<b><%=re_name%></b> (<%=re_userid %>) :  <%=re_content %> (<%=re_regdate %>)
<% 
	// 세션아이디랑 댓글아이디가 같으면 삭제버튼 출력
	if(re_userid.equals(userid)){
%>
	<button type="button" onClick = "delReply('<%=re_idx%>','<%=b_idx%>')">삭제</button></p>

<%
	}
}
%>
<script>
 	// 좋아요 증가
	function plusLike() {
		const xhr = new XMLHttpRequest();
		xhr.open('get', 'total_like.jsp?b_idx=<%=b_idx %>&userid=<%=userid%>', true);
		xhr.send();
		xhr.onreadystatechange = function() {
				if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
				const result = xhr.responseText.trim();
				console.log(result);
				document.getElementById('likeCnt').innerHTML = result;
			}
		}
	}
	
	// 좋아요 감소
	function delLike() {
		const xhr = new XMLHttpRequest();
		xhr.open('get', 'delete_like.jsp?b_idx=<%=b_idx %>&userid=<%=userid%>', true);
		xhr.send();
		xhr.onreadystatechange = function() {
				if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
				const result = xhr.responseText.trim();
				console.log(result);
				document.getElementById('likeCnt').innerHTML = result;
			}
		}
	} 
	
	function like() {
		const isHeart = document.querySelector('img[title=on]');
		if(isHeart) {
			document.getElementById('heart').setAttribute('src', './heart_off.png');
			document.getElementById('heart').setAttribute('title', 'off');
		} else {
			document.getElementById('heart').setAttribute('src', './heart_on.png');
			document.getElementById('heart').setAttribute('title', 'on');
		}
		const xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
				if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
				const result = xhr.responseText.trim();
				console.log(result);
				document.getElementById('likeCnt').innerHTML = result;
			}
		xhr.open('get', 'like_ok.jsp?b_idx=<%=b_idx%>&userid=<%=userid%>', true);
		xhr.send();
		}
	}
</script>
</body>
</html>