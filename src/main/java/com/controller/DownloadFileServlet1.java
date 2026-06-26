package com.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DownloadFileServlet1")
public class DownloadFileServlet1 extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer researcherId = (Integer) session.getAttribute("userId");

        if (researcherId == null) {
            response.getWriter().println("Unauthorized access. Please login.");
            return;
        }

        // Decode URL parameters
        String filePath = URLDecoder.decode(request.getParameter("path"), "UTF-8");
        String fileName = URLDecoder.decode(request.getParameter("name"), "UTF-8");

        if (filePath == null || fileName == null) {
            response.getWriter().println("Invalid download request.");
            return;
        }

        File file = new File(filePath);

        if (!file.exists()) {
            response.getWriter().println("File not found: " + filePath);
            return;
        }

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setContentLengthLong(file.length());

        try (
            FileInputStream fis = new FileInputStream(file);
            BufferedInputStream bis = new BufferedInputStream(fis);
            OutputStream os = response.getOutputStream()
        ) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = bis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }

            os.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Download error: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}