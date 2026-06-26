<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>
<%
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
<title>Admin Dashboard</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
/* Reset and Base */
* { margin:0; padding:0; box-sizing:border-box; font-family:'Poppins', sans-serif; }
body { display:flex; min-height:100vh; background:#0f172a; color:#fff; overflow-x:hidden; }

/* Sidebar */
.sidebar {
    width:250px;
    background:#1e293b;
    display:flex;
    flex-direction:column;
    padding:30px 20px;
    position:relative;
}
.sidebar h2 { text-align:center; margin-bottom:40px; font-weight:700; color:#3b82f6; }
.sidebar a {
    color:#fff; text-decoration:none; display:flex; align-items:center; gap:10px;
    padding:12px 15px; margin-bottom:15px; border-radius:8px; transition:0.3s;
}
.sidebar a i { font-size:16px; }
.sidebar a:hover { background:#3b82f6; color:#fff; transform:translateX(5px); }

/* Main Content */
.main-content { flex:1; padding:40px 50px; position:relative; display:flex; flex-direction:column; justify-content:flex-start; align-items:center; }

/* Header */
.header {
    width:100%;
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:50px;
}
.header h1 { color:#3b82f6; font-size:32px; }

/* Animated Buttons */
.dashboard-btn {
    width:250px;
    text-align:center;
    padding:18px 0;
    margin:15px 0;
    font-size:18px;
    font-weight:500;
    border-radius:12px;
    background: linear-gradient(135deg, #3b82f6, #06b6d4);
    color:#fff;
    text-decoration:none;
    box-shadow:0 8px 20px rgba(0,0,0,0.3);
    transition:0.3s;
    display:block;
}
.dashboard-btn:hover {
    transform: translateY(-5px);
    background: linear-gradient(135deg, #2563eb, #0891b2);
    box-shadow:0 12px 25px rgba(0,0,0,0.5);
}

/* Footer */
.footer { margin-top:auto; text-align:center; color:#94a3b8; font-size:14px; padding:20px 0; }

/* Background Animation */
#bg-canvas { position:absolute; top:0; left:0; width:100%; height:100%; z-index:-1; }

/* Responsive */
@media(max-width:900px){
    body { flex-direction:column; }
    .sidebar { width:100%; flex-direction:row; overflow-x:auto; padding:20px 10px; }
    .sidebar a { flex:1; justify-content:center; margin:0 5px; }
    .main-content { padding:20px; }
}
</style>
</head>
<body>

<canvas id="bg-canvas"></canvas>

<div class="sidebar">
    <h2>Admin Panel</h2>
    <a href="User_requests.jsp"><i class="fa-solid fa-user-check"></i> Researcher Requests</a>
    <a href="Datacheck.jsp"><i class="fa-solid fa-shield"></i> Authentication</a>
    <a href="logout_admin.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<div class="main-content">
    <div class="header">
        <h1>Welcome, <%= adminUser %>!</h1>
    </div>

    <a href="User_requests.jsp" class="dashboard-btn"><i class="fa-solid fa-user-check"></i> Researcher Requests</a>
    <a href="Datacheck.jsp" class="dashboard-btn"><i class="fa-solid fa-shield"></i> Authentication</a>
    <a href="logout_admin.jsp" class="dashboard-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>

    <div class="footer">&copy; 2025 Automated Security Assessment System</div>
</div>

<script>
// Animated Background (floating dots)
const canvas = document.getElementById('bg-canvas');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

const dots = [];
const DOT_COUNT = 80;

for(let i=0;i<DOT_COUNT;i++){
    dots.push({
        x: Math.random()*canvas.width,
        y: Math.random()*canvas.height,
        r: Math.random()*3 + 1,
        dx: (Math.random()-0.5)*0.5,
        dy: (Math.random()-0.5)*0.5
    });
}

function animate(){
    ctx.clearRect(0,0,canvas.width,canvas.height);
    for(let i=0;i<DOT_COUNT;i++){
        let d = dots[i];
        ctx.beginPath();
        ctx.arc(d.x,d.y,d.r,0,Math.PI*2);
        ctx.fillStyle = 'rgba(59,130,246,0.7)';
        ctx.fill();

        d.x += d.dx;
        d.y += d.dy;

        if(d.x<0||d.x>canvas.width) d.dx*=-1;
        if(d.y<0||d.y>canvas.height) d.dy*=-1;
    }
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
