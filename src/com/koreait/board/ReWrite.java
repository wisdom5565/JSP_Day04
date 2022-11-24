package com.koreait.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.db.DBconn;

/**
 * Servlet implementation class Re
 */
@WebServlet("/ReWrite")
public class ReWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ReWrite() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
		
		String userid = (String)session.getAttribute("userid");	
		String name = (String)session.getAttribute("name");
		String re_content = request.getParameter("re_content");
		String b_idx = request.getParameter("b_idx");
		
		try {
			conn = DBconn.getConnection();
			
			if(conn != null) {
				String sql = "INSERT INTO tb_reply (re_userid, re_name, re_content, re_boardidx) VALUES (?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, name);
				pstmt.setString(3, re_content);
				pstmt.setString(4, b_idx);
				
				int cnt = pstmt.executeUpdate();
				
				if(cnt >= 1) {
					writer.print("<script>alert('댓글 입력 완료!');\r\n"
					+ "location.href='./board/view.jsp?b_idx="+b_idx+"'</script>");
				} else {
					writer.print("<script>alert('댓글 삭제 실패...');\r\n"
							+ "history.back();</script>");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
				
	}

}
