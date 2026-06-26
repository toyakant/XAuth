<%@ page import="java.sql.*, com.dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
}
int userid = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Secondary Chain Records</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
body {
    font-family:'Poppins', sans-serif;
    background: linear-gradient(135deg,#dfe9f3,#ffffff);
    margin:0; padding:0;
}
.header { text-align:center; padding:30px 0; color:#1e293b; }
.header h1 { font-size:32px; }

.cards-container {
    display:flex; flex-direction:column; gap:20px; width:90%; margin:0 auto;
}

.card {
    background:#1f2937; color:#fff; padding:20px; border-radius:12px; box-shadow:0 8px 20px rgba(0,0,0,0.3);
    transition:0.3s;
}
.card:hover { transform:scale(1.02); }
.card h3 { color:#3b82f6; margin-bottom:15px; }
.card p { margin-bottom:8px; font-size:14px; color:#cbd5e1; }
.btn-request { display:inline-block; margin-top:10px; padding:6px 12px; border-radius:6px; text-decoration:none; background:#3b82f6; color:#fff; transition:0.3s; }
.btn-request:hover { background:#2563eb; }

</style>
</head>
<body>

<div class="header">
    <h1>Secondary Chain Records (User ID: <%= userid %>)</h1>
</div>

<div class="cards-container">
<%
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM secondary_chain WHERE user_id=? ORDER BY timestamp DESC");
        ps.setInt(1, userid);
        ResultSet rs = ps.executeQuery();

        if(!rs.isBeforeFirst()) {
            out.println("<p style='text-align:center;color:#ef4444;'>No records found for user_id=" + userid + "</p>");
        }

        while(rs.next()){
%>
    <div class="card">
        <h3><%= rs.getString("filename") %> (Block ID: <%= rs.getInt("block_id") %>)</h3>
        <p><strong>Previous Hash:</strong> <%= rs.getString("previous_hash") %></p>
        <p><strong>Current Hash:</strong> <%= rs.getString("current_hash") %></p>
        <p><strong>File Hash:</strong> <%= rs.getString("file_hash") %></p>
        <p><strong>Timestamp:</strong> <%= rs.getTimestamp("timestamp") %></p>
        <p><strong>Analysis Data:</strong> <%= rs.getString("analysis_data") %></p>
        <a href="<%= rs.getString("original_path") %>" class="btn-request" target="_blank"><i class="fa-solid fa-download"></i> Download</a>
    </div>
<%
        }

        rs.close(); ps.close(); con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
</div>

</body>
</html>
