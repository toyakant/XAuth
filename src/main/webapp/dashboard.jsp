<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Dashboard | ASAA System</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
    body{
        height:100vh;
        overflow:hidden;
        color:#fff;
        background: radial-gradient(circle at top left,#0a0f1e,#13182a);
    }

    /* Floating background animation */
    .bg-shape{
        position:fixed;
        border-radius:50%;
        opacity:0.15;
        filter:blur(90px);
        animation:float 20s infinite alternate ease-in-out;
        z-index:-1;
    }
    .shape1{width:600px;height:600px;background:#00d8ff;top:-100px;left:-150px;}
    .shape2{width:500px;height:500px;background:#ff00cc;bottom:-100px;right:-150px;}
    @keyframes float{
        0%{transform:translateY(0) translateX(0);}
        50%{transform:translateY(40px) translateX(40px);}
        100%{transform:translateY(-40px) translateX(-40px);}
    }

    /* Header */
    header{
        display:flex;
        justify-content:space-between;
        align-items:center;
        padding:20px 50px;
        background:rgba(255,255,255,0.05);
        backdrop-filter:blur(10px);
        border-bottom:1px solid rgba(255,255,255,0.1);
    }
    .logo{
        font-size:1.8rem;
        font-weight:700;
        display:flex;
        align-items:center;
        gap:10px;
        color:#00d8ff;
    }
    .user-info{
        display:flex;
        align-items:center;
        gap:20px;
    }
    .user-info i{
        font-size:1.2rem;
        cursor:pointer;
        transition:0.3s;
    }
    .user-info i:hover{
        color:#00d8ff;
    }

    /* Main Layout */
    .main-container{
        display:flex;
        height:calc(100vh - 80px);
    }

    /* Sidebar */
    .sidebar{
        width:250px;
        background:rgba(255,255,255,0.03);
        backdrop-filter:blur(10px);
        display:flex;
        flex-direction:column;
        padding:30px 20px;
        border-right:1px solid rgba(255,255,255,0.1);
        transition:all 0.5s ease;
    }
    .sidebar h3{
        color:#00d8ff;
        margin-bottom:30px;
        text-align:center;
    }
    .sidebar a{
        color:#ccc;
        text-decoration:none;
        font-size:1.1rem;
        padding:12px 20px;
        border-radius:10px;
        margin:8px 0;
        display:flex;
        align-items:center;
        gap:12px;
        transition:0.3s;
    }
    .sidebar a:hover{
        background:#00d8ff;
        color:#000;
        transform:translateX(5px);
    }

    /* Content Section */
    .content{
        flex:1;
        padding:60px;
        position:relative;
        overflow:auto;
    }
    .content h1{
        font-size:2rem;
        margin-bottom:15px;
    }
    .content p{
        max-width:800px;
        line-height:1.6;
        color:#ccc;
    }

    /* Dashboard Cards */
    .cards{
        display:grid;
        grid-template-columns:repeat(auto-fit, minmax(250px,1fr));
        gap:30px;
        margin-top:40px;
    }
    .card{
        background:rgba(255,255,255,0.05);
        border-radius:15px;
        padding:25px;
        backdrop-filter:blur(8px);
        transition:all 0.3s ease;
        border:1px solid rgba(255,255,255,0.1);
    }
    .card:hover{
        transform:translateY(-10px);
        box-shadow:0 0 30px rgba(0,216,255,0.4);
    }
    .card i{
        font-size:2.5rem;
        color:#00d8ff;
        margin-bottom:15px;
    }
    .card h3{
        font-size:1.3rem;
        margin-bottom:10px;
        color:#fff;
    }
    .card p{
        font-size:0.95rem;
        color:#aaa;
    }

    /* Footer */
    footer{
        position:fixed;
        bottom:0;
        width:100%;
        text-align:center;
        padding:15px 0;
        font-size:0.9rem;
        color:#888;
        background:rgba(255,255,255,0.05);
        backdrop-filter:blur(8px);
        border-top:1px solid rgba(255,255,255,0.1);
    }
</style>
</head>

<body>
<div class="bg-shape shape1"></div>
<div class="bg-shape shape2"></div>

<header>
    <div class="logo"><i class="fa-solid fa-shield-halved"></i> ASAA Portal</div>
    <div class="user-info">
        <i class="fa-solid fa-bell"></i>
        <i class="fa-solid fa-user-circle"></i>
    </div>
</header>

<div class="main-container">
    <div class="sidebar">
        <h3>Dashboard</h3>
        <a href="upload.jsp"><i class="fa-solid fa-upload"></i> Upload</a>
        <a href="viewrequest.jsp"><i class="fa-solid fa-eye"></i> View Request</a>
        <a href="index.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    </div>

    <div class="content">
        <h1>Welcome to ASAA System Dashboard</h1>
        <p>Manage your file uploads, view requests, and perform secure operations under the AI-powered Automated Security Assessment & Approval System. Every action you take here is protected with blockchain-integrated intelligence.</p>

        <div class="cards">
            <div class="card">
                <i class="fa-solid fa-cloud-upload-alt"></i>
                <h3>Upload Files</h3>
                <p>Securely upload sensitive files for automated assessment and approval workflows.</p>
            </div>
            <div class="card">
                <i class="fa-solid fa-chart-line"></i>
                <h3>Request Insights</h3>
                <p>Monitor request analytics and approval history in real-time.</p>
            </div>
            <div class="card">
                <i class="fa-solid fa-lock"></i>
                <h3>Data Security</h3>
                <p>Experience next-level encryption and privacy protection built into every operation.</p>
            </div>
        </div>
    </div>
</div>

<footer>
    © 2025 Automated Security Assessment & Approval System | Intelligent Data Protection
</footer>

</body>
</html>
