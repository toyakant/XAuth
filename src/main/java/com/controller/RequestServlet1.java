package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.dao.DBConnection;

@WebServlet("/RequestFilesServlet12")
public class RequestServlet1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RequestServlet1() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBConnection.getConnection()) {

            HttpSession session = request.getSession();
            Integer receiverId = (Integer) session.getAttribute("userId"); // requester

            // Get parameters from JSP form
            int blockId = Integer.parseInt(request.getParameter("blockId"));
            String prevHash = request.getParameter("prevHash");
            String currHash = request.getParameter("currHash");
            int ownerId = Integer.parseInt(request.getParameter("userId"));
            String filename = request.getParameter("filename");
            String fileHash = request.getParameter("fileHash");
            String timestampStr = request.getParameter("timestamp");
            String analysisData = request.getParameter("analysisData");

            Timestamp timestamp = null;
            try {
                timestamp = Timestamp.valueOf(timestampStr);
            } catch (Exception e) {
                timestamp = new Timestamp(System.currentTimeMillis());
            }

            // 1️⃣ Insert into requested_files
            String insertRequestSQL = "INSERT INTO requested_files(block_id, previous_hash, current_hash, user_id, filename, file_hash, timestamp, analysis_data, status, receiver_id) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = con.prepareStatement(insertRequestSQL)) {
                ps.setInt(1, blockId);
                ps.setString(2, prevHash);
                ps.setString(3, currHash);
                ps.setInt(4, ownerId);
                ps.setString(5, filename);
                ps.setString(6, fileHash);
                ps.setTimestamp(7, timestamp);
                ps.setString(8, analysisData);
                ps.setString(9, "Pending");
                ps.setInt(10, receiverId);

                int inserted = ps.executeUpdate();

                if (inserted > 0) {
                    // 2️⃣ Fetch owner (sender) and receiver names
                    String ownerName = null;
                    String receiverName = null;

                    try (PreparedStatement ps1 = con.prepareStatement("SELECT username FROM users WHERE user_id=?")) {
                        ps1.setInt(1, ownerId);
                        try (ResultSet rs1 = ps1.executeQuery()) {
                            if (rs1.next()) ownerName = rs1.getString("username");
                        }
                    }

                    try (PreparedStatement ps2 = con.prepareStatement("SELECT username FROM users WHERE user_id=?")) {
                        ps2.setInt(1, receiverId);
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            if (rs2.next()) receiverName = rs2.getString("username");
                        }
                    }

                    // 3️⃣ Insert into smartcontract
                    String insertSC = "INSERT INTO smartcontract(owner_name, request_id, sender_user_id, receiver_user_id, block_id, file_hash, analysis_data, status) "
                            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                    try (PreparedStatement ps3 = con.prepareStatement(insertSC)) {
                        ps3.setString(1, ownerName);
                        ps3.setString(2, receiverName); // storing receiver name as request_id
                        ps3.setInt(3, ownerId);
                        ps3.setInt(4, receiverId);
                        ps3.setInt(5, blockId);
                        ps3.setString(6, fileHash);
                        ps3.setString(7, analysisData);
                        ps3.setString(8, "Sc_Pending");
                        ps3.executeUpdate();
                    }
                }
            }

            response.sendRedirect("userdashboard.jsp?msg=Request sent successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("secondary_chain_view.jsp?msg=Error while requesting file");
        }
    }
}
