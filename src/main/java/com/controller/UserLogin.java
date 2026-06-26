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
 * Servlet implementation class UserLogin
 */
@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public UserLogin() {
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
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");

	    try (Connection con = DBConnection.getConnection()) {
	        String hash = HashUtil.sha256(password);
	        PreparedStatement ps = con.prepareStatement(
	            "SELECT * FROM users WHERE username=? AND password_hash=?");
	        ps.setString(1, username);
	        ps.setString(2, hash);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            String role = rs.getString("role"); // get role
	            HttpSession session = request.getSession();
	            session.setAttribute("userId", rs.getInt("user_id"));
	            session.setAttribute("role", role);
	            session.setAttribute("username", username);

	            // Record login action in blockchain
	            String details = "User login: " + username;
	            String prevHash = getLastBlockHash(con);
	            String currHash = HashUtil.sha256(prevHash + username + System.currentTimeMillis());

	            PreparedStatement ps2 = con.prepareStatement(
	                "INSERT INTO primary_chain(previous_hash, current_hash, user_id, action_type, action_details) VALUES(?,?,?,?,?)");
	            ps2.setString(1, prevHash);
	            ps2.setString(2, currHash);
	            ps2.setInt(3, rs.getInt("user_id"));
	            ps2.setString(4, "LOGIN");
	            ps2.setString(5, details);
	            ps2.executeUpdate();

	            // Redirect based on role
	            if ("OWNER".equalsIgnoreCase(role)) {
	                response.sendRedirect("dashboard.jsp");
	            } else if ("RESEARCHER".equalsIgnoreCase(role)) {
	                response.sendRedirect("userdashboard.jsp");
	            } else {
	                // default fallback
	                response.sendRedirect("login.jsp?msg=Unauthorized role");
	            }

	        } else {
	            response.sendRedirect("login.jsp?msg=Invalid credentials");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


    private String getLastBlockHash(Connection con) throws SQLException {
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT current_hash FROM primary_chain ORDER BY block_id DESC LIMIT 1");
        if (rs.next()) return rs.getString(1);
        return "0";
    
	}

}
