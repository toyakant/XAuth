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

import com.dao.DBConnection;
import com.dao.HashUtil;

/**
 * Servlet implementation class UserAuthentication
 */
@WebServlet("/RegisterServlet")
public class UserAuthentication extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public UserAuthentication() {
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
		String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection con = DBConnection.getConnection()) {
            String hashedPassword = HashUtil.sha256(password);

            // Insert user
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(username, email, password_hash, role) VALUES(?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, hashedPassword);
            ps.setString(4, role);
            ps.executeUpdate();

            // Get user ID
            ResultSet rs = ps.getGeneratedKeys();
            int userId = 0;
            if (rs.next()) userId = rs.getInt(1);

            // Insert into blockchain ledger
            String details = "User registered: " + username + " (" + role + ")";
            String prevHash = getLastBlockHash(con);
            String dataToHash = prevHash + userId + details + System.currentTimeMillis();
            String currHash = HashUtil.sha256(dataToHash);

            PreparedStatement ps2 = con.prepareStatement(
                "INSERT INTO primary_chain(previous_hash, current_hash, user_id, action_type, action_details) VALUES(?,?,?,?,?)");
            ps2.setString(1, prevHash);
            ps2.setString(2, currHash);
            ps2.setInt(3, userId);
            ps2.setString(4, "REGISTER");
            ps2.setString(5, details);
            ps2.executeUpdate();

            response.sendRedirect("login.jsp?msg=Registration Successful");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?msg=Error: " + e.getMessage());
        }
    }

    private String getLastBlockHash(Connection con) throws SQLException {
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT current_hash FROM primary_chain ORDER BY block_id DESC LIMIT 1");
        if (rs.next()) return rs.getString(1);
        return "0"; // Genesis block
    }
	

}
