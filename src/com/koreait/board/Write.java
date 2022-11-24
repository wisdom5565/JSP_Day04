package com.koreait.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.db.DBconn;

/**
 * Servlet implementation class Write
 */
@WebServlet("/Write")
public class Write extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Write() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		PreparedStatement pstmt = null;

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		PrintWriter writer = response.getWriter();
		String userid = (String)session.getAttribute("userid");
		String name = (String)session.getAttribute("name");
		
		String b_title = request.getParameter("b_title");
		String b_content = request.getParameter("b_content");
		
		try {
			conn = DBconn.getConnection();
			if(conn != null){
				String sql = "INSERT INTO tb_board (b_userid, b_name, b_title, b_content) VALUES (?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1,userid);
				pstmt.setString(2,name);
				pstmt.setString(3,b_title);
				pstmt.setString(4,b_content);
				
				int cnt = pstmt.executeUpdate();
				
				if(cnt >= 1) {
					writer.print("<script>alert('글 등록 완료!');\r\n" + 
							"location.href='./board/list.jsp';</script>");
				} else {
					writer.print("<script>alert('글 등록 실패..!');\r\n"+
							"history.back();\r\n"+
							"</script>");
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

	}

}
