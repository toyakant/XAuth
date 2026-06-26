<%@ page import="java.sql.*, com.dao.DBConnection, java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
}
int receiverId = (Integer)session.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Approved File Requests</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Roboto',sans-serif;}
body{display:flex;min-height:100vh;background:#f3f4f6;color:#111827;}

.sidebar{
width:260px;background:#1f2937;color:#fff;flex-shrink:0;
padding:30px 20px;display:flex;flex-direction:column;
}

.sidebar h3{text-align:center;margin-bottom:40px;}

.sidebar a{
display:flex;align-items:center;gap:12px;color:#fff;
text-decoration:none;padding:12px 15px;margin-bottom:15px;
border-radius:8px;transition:0.3s;
}

.sidebar a:hover{background:#374151;}

.main-content{flex:1;padding:30px;display:flex;flex-direction:column;}

.header{display:flex;justify-content:space-between;align-items:center;margin-bottom:30px;}

.records-container{display:flex;flex-direction:column;gap:20px;}

.record-card{
background:#fff;border-radius:12px;padding:20px;
box-shadow:0 6px 20px rgba(0,0,0,0.1);
display:flex;flex-direction:column;gap:8px;
}

.btn-download{
padding:8px 16px;border:none;border-radius:6px;
background:linear-gradient(90deg,#10b981,#3b82f6);
color:#fff;cursor:pointer;margin-top:10px;
text-decoration:none;display:inline-block;
}
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
<h2>Approved File Requests</h2>
<div class="user-info">
<i class="fa-solid fa-user"></i>
<strong><%= receiverId %></strong>
</div>
</div>

<div class="records-container">

<%
try{

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT r.*, s.original_path FROM requested_files r " +
"JOIN secondary_chain s ON r.block_id = s.block_id " +
"AND r.filename = s.filename AND r.file_hash = s.file_hash " +
"WHERE r.receiver_id = ? AND r.status = 'Approved'"
);

ps.setInt(1, receiverId);

ResultSet rs = ps.executeQuery();

while(rs.next()){

String filePath = rs.getString("original_path");
String fileName = rs.getString("filename");

String encodedPath = URLEncoder.encode(filePath,"UTF-8");
String encodedName = URLEncoder.encode(fileName,"UTF-8");
%>

<div class="record-card">

<h3>
Request ID: <%= rs.getInt("request_id") %> |
Block ID: <%= rs.getInt("block_id") %>
</h3>

<p><b>Filename:</b> <%= fileName %></p>
<p><b>File Hash:</b> <%= rs.getString("file_hash") %></p>
<p><b>Analysis Data:</b> <%= rs.getString("analysis_data") %></p>
<p><b>Timestamp:</b> <%= rs.getTimestamp("timestamp") %></p>

<a href="DownloadFileServlet1?path=<%=encodedPath%>&name=<%=encodedName%>"
class="btn-download">
Download
</a>

</div>

<%
}

rs.close();
ps.close();
con.close();

}catch(Exception e){
e.printStackTrace();
}
%>

</div>

</div>

</body>
</html>