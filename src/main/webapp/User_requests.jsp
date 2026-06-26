<%@ page import="java.sql.*, com.dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Ensure admin session
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect("admin_login.jsp?msg=Please login first");
        return;
    }
    String adminUser = (String) session.getAttribute("adminUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>All Requested Files</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Poppins', sans-serif; }
body { background:#0f172a; color:#fff; display:flex; min-height:100vh; }

/* Sidebar */
.sidebar {
    width:250px; background:#1e293b; display:flex; flex-direction:column; padding:30px 20px;
}
.sidebar h2 { text-align:center; margin-bottom:40px; font-weight:700; color:#3b82f6; }
.sidebar a { color:#fff; text-decoration:none; display:flex; align-items:center; gap:10px; padding:12px 15px; margin-bottom:15px; border-radius:8px; transition:0.3s; }
.sidebar a i { font-size:16px; }
.sidebar a:hover { background:#3b82f6; transform:translateX(5px); }

/* Main content */
.main-content { flex:1; padding:40px 50px; display:flex; flex-direction:column; overflow-y:auto; }
.header { display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; }
.header h1 { color:#3b82f6; font-size:28px; }
.header .user-info { color:#94a3b8; }

/* Cards */
.cards-container { display:flex; flex-direction:column; gap:20px; }
.card {
    background:#1f2937; padding:20px; border-radius:12px; box-shadow:0 8px 20px rgba(0,0,0,0.3);
    transition:0.3s; cursor:pointer;
}
.card:hover { transform:scale(1.02); }
.card h3 { margin-bottom:15px; color:#3b82f6; }
.card p { margin-bottom:8px; font-size:14px; color:#cbd5e1; }
.card .status { display:inline-block; padding:5px 10px; border-radius:6px; font-weight:600; margin-top:5px; }
.status.Pending { background:#f59e0b; color:#fff; }
.status.Approved { background:#10b981; color:#fff; }
.status.Rejected { background:#ef4444; color:#fff; }

/* Footer */
.footer { margin-top:auto; text-align:center; color:#94a3b8; font-size:14px; padding:20px 0; }

/* Animated background dots */
#bg-canvas { position:absolute; top:0; left:0; width:100%; height:100%; z-index:-1; }
</style>
</head>
<body>

<canvas id="bg-canvas"></canvas>

<div class="sidebar">
    <h2>Admin Panel</h2>
    <a href="User_requests.jsp"><i class="fa-solid fa-user-check"></i> Researcher Requests</a>
    <a href="Datacheck.jsp"><i class="fa-solid fa-shield"></i> Authentication</a>
   <!--  <a href="AllRequestedFiles.jsp"><i class="fa-solid fa-file-lines"></i> All Requested Files</a> -->
    <a href="admin.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<div class="main-content">
    <div class="header">
        <h1>All Requested Files</h1>
        <div class="user-info"><i class="fa-solid fa-user"></i> <%= adminUser %></div>
    </div>

    <div class="cards-container">
        <%
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM requested_files ORDER BY timestamp DESC");
            ResultSet rs = ps.executeQuery();

            if(!rs.isBeforeFirst()) {
                out.println("<p style='color:#f59e0b; text-align:center;'>No records found</p>");
            }

            while(rs.next()) {
        %>
        <div class="card">
            <h3><%= rs.getString("filename") %> (Block ID: <%= rs.getInt("block_id") %>)</h3>
            <p><strong>Request ID:</strong> <%= rs.getInt("request_id") %></p>
            <p><strong>User ID:</strong> <%= rs.getInt("user_id") %> | <strong>Receiver ID:</strong> <%= rs.getInt("receiver_id") %></p>
            <p><strong>Previous Hash:</strong> <%= rs.getString("previous_hash") %></p>
            <p><strong>Current Hash:</strong> <%= rs.getString("current_hash") %></p>
            <p><strong>File Hash:</strong> <%= rs.getString("file_hash") %></p>
            <p><strong>Analysis Data:</strong> <%= rs.getString("analysis_data") %></p>
            <p><strong>Timestamp:</strong> <%= rs.getTimestamp("timestamp") %></p>
            <span class="status <%= rs.getString("status") %>"><%= rs.getString("status") %></span>
        </div>
        <%
            }
            rs.close(); ps.close(); con.close();
        } catch(Exception e){ e.printStackTrace(); }
        %>
    </div>

    <div class="footer">&copy; 2025 Automated Security Assessment System</div>
</div>

<script>
// Animated background dots
const canvas = document.getElementById('bg-canvas');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

const dots = [];
const DOT_COUNT = 80;
for(let i=0;i<DOT_COUNT;i++){
    dots.push({ x: Math.random()*canvas.width, y: Math.random()*canvas.height, r: Math.random()*3+1, dx:(Math.random()-0.5)*0.5, dy:(Math.random()-0.5)*0.5 });
}

function animate(){
    ctx.clearRect(0,0,canvas.width,canvas.height);
    dots.forEach(d=>{
        ctx.beginPath();
        ctx.arc(d.x,d.y,d.r,0,Math.PI*2);
        ctx.fillStyle='rgba(59,130,246,0.5)';
        ctx.fill();
        d.x+=d.dx; d.y+=d.dy;
        if(d.x<0||d.x>canvas.width) d.dx*=-1;
        if(d.y<0||d.y>canvas.height) d.dy*=-1;
    });
    requestAnimationFrame(animate);
}
animate();

window.addEventListener('resize',()=>{
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
});
</script>

</body>
</html>
