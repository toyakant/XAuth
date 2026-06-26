package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.DBConnection;

@WebServlet("/UpdateRequestStatusServlet")
public class UpdateRequestStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateRequestStatusServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            int blockId = Integer.parseInt(request.getParameter("blockId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int receiverId = Integer.parseInt(request.getParameter("receiverId"));

            String newStatus = "";
            if ("approve".equalsIgnoreCase(action)) {
                newStatus = "Approved";
            } else if ("reject".equalsIgnoreCase(action)) {
                newStatus = "Rejected";
            } else {
                response.sendRedirect("pending_requests.jsp?msg=Invalid action");
                return;
            }

            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE requested_files SET status = ? WHERE request_id = ?");
            ps.setString(1, newStatus);
            ps.setInt(2, requestId);
            int updated = ps.executeUpdate();

            if (updated > 0) {
                // Update related smartcontract entry
                PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE smartcontract SET status = ? WHERE sender_user_id = ? AND receiver_user_id = ? AND block_id = ?"
                );
                ps2.setString(1, newStatus);
                ps2.setInt(2, userId);
                ps2.setInt(3, receiverId);
                ps2.setInt(4, blockId);
                ps2.executeUpdate();

                response.sendRedirect("viewrequest.jsp?msg=Request " + newStatus + " successfully");
            } else {
                response.sendRedirect("pending_requests.jsp?msg=Failed to update request");
            }

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pending_requests.jsp?msg=Error while updating request");
        }
    }
}
