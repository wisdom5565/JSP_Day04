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
 * Servlet implementation class Edit
 */
@WebServlet("/Edit")
public class Edit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Edit() {
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
		PrintWriter writer = response.getWriter();
		
		String b_idx = request.getParameter("b_idx");
		String b_title =  request.getParameter("b_title");
		String b_content =  request.getParameter("b_content");
		
		try {
			conn = DBconn.getConnection();
			if(conn != null) {
				String sql = "UPDATE tb_board SET b_title = ? , b_content = ? WHERE b_idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_title);
				pstmt.setString(2, b_content);
				pstmt.setString(3, b_idx);
				
				int cnt = pstmt.executeUpdate();
				if(cnt >= 1) {
					writer.print("<script>alert('글 수정 완료!');\r\n"
							+ "location.href='./board/view.jsp?b_idx="+b_idx+"'</script>");
				} else {
					writer.print("<script>alert('글 수정 실패...');\r\n"
							+ "history.back();</script>");
				}
			}	
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
