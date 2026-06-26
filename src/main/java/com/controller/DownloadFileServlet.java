package com.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DBConnection;
import com.service.AESUtil;

/**
 * Servlet implementation class DownloadFileServlet
 */
@WebServlet("/DownloadFileServlet.....")
public class DownloadFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadFileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 HttpSession session = request.getSession();
	        Integer researcherId = (Integer) session.getAttribute("userId");
	        String role = (String) session.getAttribute("role");

	        if (researcherId == null || !role.equals("RESEARCHER")) {
	            response.sendRedirect("login.jsp?msg=Access denied");
	            return;
	        }

	        int requestId = Integer.parseInt(request.getParameter("requestId"));

	        try (Connection con = DBConnection.getConnection()) {
	            // Check if request approved
	            PreparedStatement ps1 = con.prepareStatement(
	                "SELECT ar.status, sc.filename, sc.file_path, sc.encryption_key " +
	                "FROM access_requests ar JOIN secondary_chain sc ON ar.file_id = sc.block_id " +
	                "WHERE ar.request_id=? AND ar.researcher_id=?");
	            ps1.setInt(1, requestId);
	            ps1.setInt(2, researcherId);
	            ResultSet rs = ps1.executeQuery();

	            if (rs.next()) {
	                String status = rs.getString("status");
	                if (!status.equals("APPROVED")) {
	                    response.getWriter().println("Request not approved yet.");
	                    return;
	                }

	                String filename = rs.getString("filename");
	                String filePath = rs.getString("file_path");
	                String aesKey = rs.getString("encryption_key");

	                File encryptedFile = new File(filePath);
	                File tempFile = new File(filePath + "_tmp");

	                AESUtil.decryptFile(encryptedFile, tempFile, aesKey);

	                response.setContentType("application/octet-stream");
	                response.setHeader("Content-Disposition", "attachment;filename=" + filename);

	                try (FileInputStream fis = new FileInputStream(tempFile);
	                     OutputStream os = response.getOutputStream()) {
	                    byte[] buffer = new byte[1024];
	                    int bytesRead;
	                    while ((bytesRead = fis.read(buffer)) != -1) {
	                        os.write(buffer, 0, bytesRead);
	                    }
	                }
	                tempFile.delete();

	            } else {
	                response.getWriter().println("Request not found or invalid user.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().println("Error: " + e.getMessage());
	        }
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
