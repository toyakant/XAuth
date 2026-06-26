package com.controller;

import java.io.*;
import java.sql.*;
import java.util.Random;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import com.dao.DBConnection;
import com.dao.HashUtil;
import com.service.AESUtil;

@WebServlet("/FileUploadServlet")
@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp?msg=Login required");
            return;
        }

        Part filePart = request.getPart("file");
        String fileName = new File(filePart.getSubmittedFileName()).getName();
        String appPath = request.getServletContext().getRealPath("");

        // Create separate folders for original and encrypted files
        String originalPath = appPath + File.separator + UPLOAD_DIR + File.separator + "original";
        String encryptedPath = appPath + File.separator + UPLOAD_DIR + File.separator + "encrypted";
        new File(originalPath).mkdirs();
        new File(encryptedPath).mkdirs();

        // Save original file
        File originalFile = new File(originalPath + File.separator + fileName);
        try (FileOutputStream fos = new FileOutputStream(originalFile);
             InputStream is = filePart.getInputStream()) {
            byte[] buffer = new byte[1024];
            int len;
            while ((len = is.read(buffer)) > 0) {
                fos.write(buffer, 0, len);
            }
        }

        // Analyze file
        String analysisData = "";
        String lowerName = fileName.toLowerCase();
        Random rand = new Random();

        try {
            if (lowerName.endsWith(".txt") || lowerName.endsWith(".pdf")) {
                analysisData = extractLongestWord(originalFile);
            } else if (lowerName.endsWith(".docx")) {
                analysisData = "DOCX-" + System.currentTimeMillis() + "-" + (rand.nextInt(9000) + 1000);
            } else if (lowerName.endsWith(".png") || lowerName.endsWith(".jpg") ||
                       lowerName.endsWith(".jpeg") || lowerName.endsWith(".bmp")) {
                StringBuilder sb = new StringBuilder();
                int pixels = 100;
                for (int i = 0; i < pixels; i++) {
                    int r = rand.nextInt(256);
                    int g = rand.nextInt(256);
                    int b = rand.nextInt(256);
                    sb.append((r << 16) | (g << 8) | b).append(",");
                }
                analysisData = sb.toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Encrypt file
        try (Connection con = DBConnection.getConnection()) {
            String aesKey = AESUtil.generateKey();
            File encryptedFile = new File(encryptedPath + File.separator + "enc_" + fileName);
            AESUtil.encryptFile(originalFile, encryptedFile, aesKey);

            // Compute hashes
            String fileHash = HashUtil.sha256(fileName + System.currentTimeMillis());
            String prevHash = getLastBlockHash(con);
            String currHash = HashUtil.sha256(prevHash + fileHash + aesKey + System.currentTimeMillis());

            // Insert metadata (original + encrypted path)
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO secondary_chain (previous_hash, current_hash, user_id, filename, file_path, encryption_key, file_hash, analysis_data,original_path) VALUES (?,?,?,?,?,?,?,?,?)"
            );
            ps.setString(1, prevHash);
            ps.setString(2, currHash);
            ps.setInt(3, userId);
            ps.setString(4, fileName);
            ps.setString(5, encryptedFile.getAbsolutePath());
            ps.setString(6, aesKey);
            ps.setString(7, fileHash);
            ps.setString(8, analysisData);
            ps.setString(9, originalFile.getAbsolutePath());

            ps.executeUpdate();

            response.sendRedirect("upload_success.jsp?file=" + fileName);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?msg=Upload error: " + e.getMessage());
        }
    }

    private String getLastBlockHash(Connection con) throws SQLException {
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT current_hash FROM secondary_chain ORDER BY block_id DESC LIMIT 1");
        if (rs.next()) return rs.getString(1);
        return "0";
    }

    private String extractLongestWord(File file) throws IOException {
        String content = "";
        String name = file.getName().toLowerCase();

        if (name.endsWith(".txt")) {
            content = new String(java.nio.file.Files.readAllBytes(file.toPath()));
        } else if (name.endsWith(".pdf")) {
            try (PDDocument doc = PDDocument.load(file)) {
                PDFTextStripper stripper = new PDFTextStripper();
                content = stripper.getText(doc);
            }
        }

        String longest = "";
        for (String word : content.split("\\s+")) {
            if (word.length() > longest.length()) longest = word;
        }
        return longest;
    }
}
