<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - File Upload</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Roboto', sans-serif; }
    body, html { height: 100%; overflow: hidden; }

    /* Canvas background */
    canvas#bgCanvas {
        position: fixed;
        top: 0;
        left: 0;
        z-index: -1;
        width: 100%;
        height: 100%;
        background: #0f172a;
    }

    /* Sidebar */
    .sidebar {
        width: 260px;
        background: rgba(31,41,55,0.95);
        color: #fff;
        flex-shrink: 0;
        display: flex;
        flex-direction: column;
        padding: 30px 20px;
        position: fixed;
        height: 100%;
    }

    .sidebar h3 { text-align: center; margin-bottom: 40px; font-weight: 700; }
    .sidebar a { display: flex; align-items: center; gap: 12px; color: #fff; text-decoration: none;
        padding: 12px 15px; margin-bottom: 15px; border-radius: 8px; transition: 0.3s; }
    .sidebar a:hover { background: #374151; }

    /* Main content */
    .main-content {
        margin-left: 260px;
        padding: 40px;
        color: #f9fafb;
        min-height: 100vh;
    }

    .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
    .header h2 { color: #f9fafb; }
    .header .user-info { display: flex; align-items: center; gap: 10px; font-size: 14px; color: #cbd5e1; }
    .header .user-info i { color: #94a3b8; }

    /* Upload Card */
    .upload-card {
        background: rgba(255,255,255,0.05);
        padding: 40px;
        border-radius: 12px;
        backdrop-filter: blur(10px);
        box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        max-width: 600px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        gap: 20px;
        transition: transform 0.3s;
        border: 1px solid rgba(255,255,255,0.1);
    }

    .upload-card:hover { transform: translateY(-5px); }
    .upload-card input[type="file"] {
        padding: 15px;
        border-radius: 8px;
        border: 1px solid #94a3b8;
        cursor: pointer;
        background: rgba(255,255,255,0.1);
        color: #fff;
    }

    .upload-card button {
        padding: 15px;
        border: none;
        border-radius: 8px;
        background: linear-gradient(90deg, #3b82f6, #06b6d4);
        color: #fff;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
    }

    .upload-card button:hover {
        background: linear-gradient(90deg, #2563eb, #0891b2);
    }

    /* Footer */
    .footer { margin-top: 50px; text-align: center; color: #94a3b8; font-size: 14px; }

    /* Responsive */
    @media(max-width:768px){
        .sidebar { position: relative; width: 100%; height: auto; flex-direction: row; overflow-x:auto; }
        .sidebar h3 { display:none; }
        .sidebar a { flex: 1; text-align:center; padding:12px 0; }
        .main-content { margin-left: 0; padding: 20px; }
    }
</style>
</head>
<body>

<!-- Background Canvas -->
<canvas id="bgCanvas"></canvas>

<!-- Sidebar -->
<div class="sidebar">
    <h3>Dashboard</h3>
    <a href="upload.jsp"><i class="fa-solid fa-upload"></i> Upload</a>
    <a href="mydata.jsp"><i class="fa-solid fa-upload"></i> My Data</a>
    <a href="viewrequest.jsp"><i class="fa-solid fa-eye"></i> View Request</a>
    <a href="index.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="header">
        <h2>File Upload</h2>
        <div class="user-info"><i class="fa-solid fa-user"></i> Welcome, <strong><%= session.getAttribute("userId") %></strong></div>
    </div>

    <div class="upload-card">
        <h3>Upload File (Secondary Blockchain Storage)</h3>
        <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
            <input type="file" name="file" required>
            <button type="submit"><i class="fa-solid fa-upload"></i> Upload File</button>
        </form>
    </div>

    <div class="footer">&copy; 2025 Automated Security Assessment System. All rights reserved.</div>
</div>

<!-- JS Animated Background -->
<script>
const canvas = document.getElementById('bgCanvas');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let nodes = [];
const nodeCount = 80;

class Node {
    constructor() {
        this.x = Math.random()*canvas.width;
        this.y = Math.random()*canvas.height;
        this.radius = Math.random()*3+1;
        this.vx = (Math.random()-0.5)*0.5;
        this.vy = (Math.random()-0.5)*0.5;
    }
    update() {
        this.x += this.vx;
        this.y += this.vy;
        if(this.x<0 || this.x>canvas.width) this.vx*=-1;
        if(this.y<0 || this.y>canvas.height) this.vy*=-1;
    }
    draw() {
        ctx.beginPath();
        ctx.arc(this.x,this.y,this.radius,0,Math.PI*2);
        ctx.fillStyle = 'rgba(59,130,246,0.7)';
        ctx.fill();
    }
}

for(let i=0;i<nodeCount;i++) nodes.push(new Node());

function animate() {
    ctx.clearRect(0,0,canvas.width,canvas.height);
    nodes.forEach(node=>{
        node.update();
        node.draw();
    });

    // Draw connections
    for(let i=0;i<nodeCount;i++){
        for(let j=i+1;j<nodeCount;j++){
            let dx = nodes[i].x - nodes[j].x;
            let dy = nodes[i].y - nodes[j].y;
            let dist = Math.sqrt(dx*dx + dy*dy);
            if(dist<120){
                ctx.beginPath();
                ctx.moveTo(nodes[i].x,nodes[i].y);
                ctx.lineTo(nodes[j].x,nodes[j].y);
                ctx.strokeStyle='rgba(59,130,246,'+(1-dist/120)+')';
                ctx.lineWidth=1;
                ctx.stroke();
            }
        }
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
