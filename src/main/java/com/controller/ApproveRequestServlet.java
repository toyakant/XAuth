package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DBConnection;
import com.dao.HashUtil;

/**
 * Servlet implementation class ApproveRequestServlet
 */
@WebServlet("/ApproveRequestServlet")
public class ApproveRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApproveRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 HttpSession session = request.getSession();
	        Integer ownerId = (Integer) session.getAttribute("userId");
	        String role = (String) session.getAttribute("role");

	        if (ownerId == null || !role.equals("OWNER")) {
	            response.sendRedirect("login.jsp?msg=Access denied");
	            return;
	        }

	        int requestId = Integer.parseInt(request.getParameter("requestId"));
	        String action = request.getParameter("action"); // APPROVE or REJECT

	        try (Connection con = DBConnection.getConnection()) {
	            String status = action.equalsIgnoreCase("APPROVE") ? "APPROVED" : "REJECTED";
	            PreparedStatement ps = con.prepareStatement(
	                "UPDATE access_requests SET status=?, approval_time=NOW() WHERE request_id=?");
	            ps.setString(1, status);
	            ps.setInt(2, requestId);
	            ps.executeUpdate();

	            // Log in Primary Blockchain
	            String prevHash = getLastPrimaryHash(con);
	            String details = "Owner " + ownerId + " " + status + " request " + requestId;
	            String currHash = HashUtil.sha256(prevHash + details + System.currentTimeMillis());

	            PreparedStatement ps2 = con.prepareStatement(
	                "INSERT INTO primary_chain(previous_hash, current_hash, user_id, action_type, action_details) VALUES(?,?,?,?,?)");
	            ps2.setString(1, prevHash);
	            ps2.setString(2, currHash);
	            ps2.setInt(3, ownerId);
	            ps2.setString(4, "REQUEST_" + status);
	            ps2.setString(5, details);
	            ps2.executeUpdate();

	            response.sendRedirect("owner_requests.jsp?msg=Request " + status);
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("owner_requests.jsp?msg=Error: " + e.getMessage());
	        }
	    }

	    private String getLastPrimaryHash(Connection con) throws SQLException {
	        Statement st = con.createStatement();
	        ResultSet rs = st.executeQuery("SELECT current_hash FROM primary_chain ORDER BY block_id DESC LIMIT 1");
	        if (rs.next()) return rs.getString(1);
	        return "0";
	    }

}
