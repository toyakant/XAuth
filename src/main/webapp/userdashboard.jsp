<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<title>Researcher Dashboard</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
    * { margin:0; padding:0; box-sizing:border-box; font-family: 'Roboto', sans-serif; }
    body { display:flex; min-height:100vh; background:#f0f4f8; color:#111827; }

    /* Sidebar */
    .sidebar {
        width: 260px;
        background: #1f2937;
        color: #fff;
        flex-shrink: 0;
        display: flex;
        flex-direction: column;
        padding: 30px 20px;
    }
    .sidebar h3 { text-align:center; margin-bottom:40px; font-weight:700; letter-spacing:1px; }
    .sidebar a {
        display:flex;
        align-items:center;
        gap:12px;
        color:#fff;
        text-decoration:none;
        padding:12px 15px;
        margin-bottom:15px;
        border-radius:8px;
        transition:0.3s;
    }
    .sidebar a:hover { background:#374151; }

    /* Main content */
    .main-content { flex:1; padding:40px; display:flex; flex-direction:column; }

    /* Header */
    .header { display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; }
    .header h2 { font-weight:700; }
    .header .user-info { display:flex; align-items:center; gap:10px; font-size:14px; color:#374151; }
    .header .user-info i { color:#6b7280; }

    /* Cards section */
    .cards { display:flex; gap:30px; flex-wrap:wrap; }
    .card {
        flex:1;
        min-width:220px;
        background:#fff;
        padding:30px;
        border-radius:12px;
        box-shadow:0 6px 20px rgba(0,0,0,0.1);
        text-align:center;
        transition:transform 0.3s;
        cursor:pointer;
    }
    .card:hover { transform:translateY(-5px); }
    .card i { font-size:36px; color:#3b82f6; margin-bottom:15px; }
    .card h3 { margin-bottom:10px; font-size:18px; color:#111827; }
    .card p { font-size:14px; color:#6b7280; }

    /* Footer */
    .footer { margin-top:auto; text-align:center; color:#6b7280; font-size:14px; padding:20px 0; }

    /* Responsive */
    @media(max-width:768px){
        body { flex-direction:column; }
        .sidebar { width:100%; flex-direction:row; overflow-x:auto; height:auto; padding:15px 5px; }
        .sidebar h3 { display:none; }
        .sidebar a { flex:1; text-align:center; padding:12px 0; }
        .main-content { padding:20px; }
        .cards { flex-direction:column; gap:20px; }
    }
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3>Researcher</h3>
    <a href="AvailableFiles.jsp"><i class="fa-solid fa-file-lines"></i> Available Files</a>
    <a href="getdata.jsp"><i class="fa-solid fa-database"></i> Get Data</a>
    <a href="index.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Header -->
    <div class="header">
        <h2>Hi, Welcome Researcher</h2>
        <div class="user-info"><i class="fa-solid fa-user"></i> <strong><%= userid %></strong></div>
    </div>

    <!-- Action Cards -->
    <div class="cards">
        <div class="card" onclick="location.href='AvailableFiles.jsp'">
            <i class="fa-solid fa-file-lines"></i>
            <h3>Available Files</h3>
            <p>View and access files ready for research analysis.</p>
        </div>
        <div class="card" onclick="location.href='getdata.jsp'">
            <i class="fa-solid fa-database"></i>
            <h3>Get Data</h3>
            <p>Retrieve processed data from approved requests.</p>
        </div>
    </div>

    <div class="footer">&copy; 2025 Automated Security Assessment System. All rights reserved.</div>
</div>

</body>
</html>
