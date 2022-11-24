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
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Delete() {
        super();
    
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
		
		String b_idx = request.getParameter("b_idx");
		String userid = (String)session.getAttribute("userid");
		
		try {
			conn = DBconn.getConnection();
			
			if(conn != null) {
				String sql =  "DELETE FROM tb_board WHERE b_idx = ? AND b_userid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.setString(2,userid);
						
				int cnt = pstmt.executeUpdate();
				if(cnt >= 1) {
					writer.print("<script>alert('글 삭제 완료!');\r\n"
					+ "location.href = 'board/list.jsp'</script>");
				} else {
					writer.print("<script>alert('글 삭제 실패...');\r\n"
					+ "history.back();</script>");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
