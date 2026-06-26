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
<title>Pending File Requests</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Roboto', sans-serif; }
    body { display: flex; min-height: 100vh; background: #f3f4f6; color: #111827; }

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
    .sidebar h3 { text-align: center; margin-bottom: 40px; font-weight: 700; letter-spacing: 1px; }
    .sidebar a { display: flex; align-items: center; gap: 12px; color: #fff; text-decoration: none;
        padding: 12px 15px; margin-bottom: 15px; border-radius: 8px; transition: 0.3s; }
    .sidebar a:hover { background: #374151; }

    /* Main content */
    .main-content {
        flex: 1;
        padding: 30px 50px;
    }

    /* Header */
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }
    .header h2 { font-weight: 700; }
    .header .user-info { display: flex; align-items: center; gap: 10px; font-size: 14px; color: #374151; }
    .header .user-info i { color: #6b7280; }

    /* Table card */
    .table-card {
        background: #fff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        overflow-x: auto;
    }

    table {
        border-collapse: collapse;
        width: 100%;
        min-width: 900px;
    }
    th, td {
        border: 1px solid #e5e7eb;
        padding: 12px 15px;
        text-align: left;
    }
    th { background: #1f2937; color: #fff; }
    tr:nth-child(even) { background: #f9fafb; }
    tr:hover { background: #e5e7eb; }

    .btn {
        padding: 6px 12px;
        border: none;
        border-radius: 6px;
        color: #fff;
        cursor: pointer;
        font-size: 14px;
        transition: 0.3s;
    }
    .approve { background-color: #10b981; }
    .approve:hover { background-color: #059669; }
    .reject { background-color: #ef4444; }
    .reject:hover { background-color: #b91c1c; }

    /* Footer */
    .footer {
        margin-top: 30px;
        text-align: center;
        color: #6b7280;
        font-size: 14px;
    }

    /* Responsive */
    @media(max-width:768px){
        body { flex-direction: column; }
        .sidebar { width: 100%; flex-direction: row; overflow-x:auto; height:auto; padding:15px 5px; }
        .sidebar h3 { display:none; }
        .sidebar a { flex:1; text-align:center; padding:12px 0; }
        .main-content { padding: 20px; }
        table { min-width: 600px; }
    }
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3>Dashboard</h3>
    <a href="upload.jsp"><i class="fa-solid fa-upload"></i> Upload</a>
    <a href="viewrequest.jsp"><i class="fa-solid fa-eye"></i> View Request</a>
    <a href="index.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="header">
        <h2>Pending File Requests</h2>
        <div class="user-info"><i class="fa-solid fa-user"></i> Welcome, <strong><%= userid %></strong></div>
    </div>

    <div class="table-card">
        <table>
            <tr>
                <th>Request ID</th>
                <th>Block ID</th>
                <th>User ID</th>
                <th>Receiver ID</th>
                <th>Filename</th>
                <th>File Hash</th>
                <th>Timestamp</th>
                <th>Analysis Data</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <%
                try {
                    Connection con = DBConnection.getConnection();
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM requested_files WHERE user_id = ? AND status = 'Pending'"
                    );
                    ps.setInt(1, userid);
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("request_id") %></td>
                <td><%= rs.getInt("block_id") %></td>
                <td><%= rs.getInt("user_id") %></td>
                <td><%= rs.getInt("receiver_id") %></td>
                <td><%= rs.getString("filename") %></td>
                <td><%= rs.getString("file_hash") %></td>
                <td><%= rs.getTimestamp("timestamp") %></td>
                <td><%= rs.getString("analysis_data") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <form method="post" action="UpdateRequestStatusServlet" style="display:inline;">
                        <input type="hidden" name="requestId" value="<%= rs.getInt("request_id") %>" />
                        <input type="hidden" name="blockId" value="<%= rs.getInt("block_id") %>" />
                        <input type="hidden" name="userId" value="<%= rs.getInt("user_id") %>" />
                        <input type="hidden" name="receiverId" value="<%= rs.getInt("receiver_id") %>" />
                        <input type="hidden" name="action" value="approve" />
                        <input type="submit" class="btn approve" value="Approve" />
                    </form>
                    <form method="post" action="UpdateRequestStatusServlet" style="display:inline;">
                        <input type="hidden" name="requestId" value="<%= rs.getInt("request_id") %>" />
                        <input type="hidden" name="blockId" value="<%= rs.getInt("block_id") %>" />
                        <input type="hidden" name="userId" value="<%= rs.getInt("user_id") %>" />
                        <input type="hidden" name="receiverId" value="<%= rs.getInt("receiver_id") %>" />
                        <input type="hidden" name="action" value="reject" />
                        <input type="submit" class="btn reject" value="Reject" />
                    </form>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>

    <div class="footer">&copy; 2025 Automated Security Assessment System. All rights reserved.</div>
</div>

</body>
</html>
