<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.koreait.db.DBconn"%>
<%@page import="java.sql.*"%>
<%@ include file ="../include/sessionCheck.jsp" %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int b_idx = 0;
	String b_title = "";
	String b_userid = "";
	String b_name = "";
	String b_regdate = "";
	int b_like = 0;
	int b_hit = 0;
	String sql = "";
	int b_cnt = 0;
	int pagePerCount = 10;		// 페이지당 글 갯수
	int start = 0;
	int num = 0;
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum != null && !pageNum.equals("")) {
		
		start = (Integer.parseInt(pageNum) - 1) * pagePerCount;

	} else {
		pageNum = "1";
		start = 0;
	}
	try{
		conn = DBconn.getConnection();
		if(conn != null){
			sql = "SELECT b_idx, b_userid, b_name, b_title, b_content, b_hit, b_regdate, b_like FROM tb_board ORDER BY b_regdate desc LIMIT ?,?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, pagePerCount);
					
			rs =  pstmt.executeQuery();
			
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>
<style>
	table {
		width : 800px;
		border : 1px solid black;
		border-collapse: collapse;
	}
	
	th,td {
		border : 1px solid black;
		padding : 10px;
		text-align : center;
	}
</style>
</head>
<body>
	<h2>리스트</h2>

	<%	/* 총 게시글 수*/ 
		sql = "SELECT COUNT(b_idx) AS b_cnt FROM tb_board";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs_board = pstmt.executeQuery();
		
		String boardCnt = "";
		if(rs_board.next()) {
			b_cnt = rs_board.getInt("b_cnt");
			if(b_cnt > 0) {
				boardCnt = "[ "+ b_cnt + " ]";
			}
		}
		
	%>
	<p>총 게시글 : <%= boardCnt %></p>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>날짜</th>
			<th>좋아요</th>
		</tr>
		
		
<%		/* 게시글 갖고오기 */
		while(rs.next()){
			b_idx = rs.getInt("b_idx");
			b_title = rs.getString("b_title");
			b_userid = rs.getString("b_userid");
			b_name = rs.getString("b_name");
			b_regdate = rs.getString("b_regdate");
			b_hit = rs.getInt("b_hit");
			b_like = rs.getInt("b_like"); 
		
			/* 댓글 갯수 */
			sql = "SELECT COUNT(re_idx) AS cnt FROM tb_reply WHERE re_boardidx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,b_idx);
			
			ResultSet rs_reply = pstmt.executeQuery();
			
			String replyCnt = "";
			if(rs_reply.next()) {
				int cnt = rs_reply.getInt("cnt");
				if(cnt > 0) {
					replyCnt = "[ "+ cnt + " ]";
				}
			}
			
			/* 최근 게시물  */
			// sql 함수로 날짜 차이 구하기
			sql = "SELECT TIMESTAMPDIFF(DAY, ?, now()) AS date";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_regdate);
			
			ResultSet rs_date = pstmt.executeQuery();
			
			int date = 0;
			String newKeyword =  "";
			while(rs_date.next()) {
				date = rs_date.getInt("date");
				if(date <= 3) {
					newKeyword = "[NEW]";
				}
			}
	
%>
		<tr>
			<td><%=b_cnt - 10 * (Integer.parseInt(pageNum)-1)-num%></td>
			<td><b style ="color:hotpink;"><%=newKeyword %></b><a href="view.jsp?b_idx=<%=b_idx%>"> <%=b_title %></a> <%=replyCnt%></td>
			<td><%=b_name %>(<%=b_userid %>)</td>
			<td><%=b_hit%></td>
			<td><%=b_regdate %></td>
			<td><%=b_like%></td>
		</tr>
<%
		num++;
		}
%> 
		<tr>
		<td colspan ="6">
	<%
		int pageNums = 0;
		if(b_cnt % pagePerCount == 0){
			pageNums = (b_cnt / pagePerCount);
		} else {
			pageNums = (b_cnt / pagePerCount) + 1;
		}
		
		for(int i = 1; i <= pageNums; i++) {
			out.print("<a href='list.jsp?pageNum="+ i + "'>" + i +"</a> ");
		}
	%>
		</td>
		</tr>

	</table>
	<p><button type ="button"onClick ="location.href ='write.jsp'">글쓰기</button> | <button type="button"onClick = "location.href='../login.jsp'">돌아가기</button></p>
</body>
</html>