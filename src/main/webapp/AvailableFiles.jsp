<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.dao.DBConnection"%>
<%@page import="java.sql.Connection"%>
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
<title>Secondary Chain Records</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Roboto', sans-serif; }
body { display:flex; min-height:100vh; background:#f3f4f6; color:#111827; }

.sidebar {
    width: 260px;
    background:#1f2937;
    color:#fff;
    flex-shrink:0;
    display:flex;
    flex-direction:column;
    padding:30px 20px;
}
.sidebar h3 { text-align:center; margin-bottom:40px; font-weight:700; }
.sidebar a {
    display:flex; align-items:center; gap:12px; color:#fff; text-decoration:none;
    padding:12px 15px; margin-bottom:15px; border-radius:8px; transition:0.3s;
}
.sidebar a:hover { background:#374151; }

.main-content { flex:1; padding:30px; display:flex; flex-direction:column; }

.header { display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; }
.header h2 { font-weight:700; }
.header .user-info { display:flex; align-items:center; gap:10px; font-size:14px; color:#374151; }
.header .user-info i { color:#6b7280; }

.records-container { display:flex; flex-direction:column; gap:20px; }

.record-card {
    background:#fff;
    border-radius:12px;
    padding:20px;
    box-shadow:0 6px 20px rgba(0,0,0,0.1);
    display:flex; flex-direction:column; gap:8px;
    transition: transform 0.3s;
}
.record-card:hover { transform:translateY(-5px); }

.record-card h3 { font-size:18px; color:#1f2937; margin-bottom:10px; }
.record-card p { font-size:14px; color:#6b7280; }
.record-card .data-label { font-weight:500; color:#374151; }

.record-card .btn {
    padding:8px 16px;
    border:none;
    border-radius:6px;
    background:linear-gradient(90deg,#3b82f6,#06b6d4);
    color:#fff;
    cursor:pointer;
    margin-top:10px;
    transition:0.3s;
    text-align:center;
}
.record-card .btn:hover { background:linear-gradient(90deg,#2563eb,#0891b2); }

.footer { margin-top:auto; text-align:center; color:#6b7280; font-size:14px; padding:20px 0; }

</style>
</head>
<body>

<div class="sidebar">
    <h3>Researcher</h3>
    <a href="AvailableFiles.jsp"><i class="fa-solid fa-file-lines"></i> Available Files</a>
    <a href="getdata.jsp"><i class="fa-solid fa-database"></i> Get Data</a>
    <a href="index.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<div class="main-content">
    <div class="header">
        <h2>Secondary Chain Records</h2>
        <div class="user-info"><i class="fa-solid fa-user"></i> <strong><%= userid %></strong></div>
    </div>

    <div class="records-container">
    <%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rec = null;
    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT * FROM secondary_chain ORDER BY block_id DESC");
        rec = ps.executeQuery();

        while(rec.next()){
    %>
        <div class="record-card">
            <h3>Block ID: <%= rec.getInt("block_id") %></h3>
            <p><span class="data-label">Previous Hash:</span> <%= rec.getString("previous_hash") %></p>
            <p><span class="data-label">Current Hash:</span> <%= rec.getString("current_hash") %></p>
            <p><span class="data-label">User ID:</span> <%= rec.getInt("user_id") %></p>
            <p><span class="data-label">Filename:</span> <%= rec.getString("filename") %></p>
            <p><span class="data-label">File Hash:</span> <%= rec.getString("file_hash") %></p>
            <p><span class="data-label">Timestamp:</span> <%= rec.getTimestamp("timestamp") %></p>
            <p><span class="data-label">Analysis Data:</span> <%= rec.getString("analysis_data") %></p>
            <form method="post" action="RequestFilesServlet12">
                <input type="hidden" name="blockId" value="<%= rec.getInt("block_id") %>" />
                <input type="hidden" name="prevHash" value="<%= rec.getString("previous_hash") %>" />
                <input type="hidden" name="currHash" value="<%= rec.getString("current_hash") %>" />
                <input type="hidden" name="userId" value="<%= rec.getInt("user_id") %>" />
                <input type="hidden" name="filename" value="<%= rec.getString("filename") %>" />
                <input type="hidden" name="fileHash" value="<%= rec.getString("file_hash") %>" />
                <input type="hidden" name="timestamp" value="<%= rec.getTimestamp("timestamp") %>" />
                <input type="hidden" name="analysisData" value="<%= rec.getString("analysis_data") %>" />
                <input type="submit" class="btn" value="Request" />
            </form>
        </div>
    <%
        }
    } catch(Exception e){ e.printStackTrace(); } 
    finally {
        if(rec!=null) rec.close();
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }
    %>
    </div>

    <div class="footer">&copy; 2025 Automated Security Assessment System. All rights reserved.</div>
</div>

</body>
</html>
