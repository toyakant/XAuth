<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Automated Security Assessment & Approval</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background: radial-gradient(circle at top left, #0d1117, #000);
            color: #fff;
            overflow-x: hidden;
        }

        /* === Header === */
        header {
            position: fixed;
            top: 0; width: 100%;
            background: rgba(0, 0, 0, 0.75);
            backdrop-filter: blur(12px);
            padding: 18px 60px;
            display: flex; justify-content: space-between; align-items: center;
            z-index: 100;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .logo {
            font-size: 1.7rem;
            font-weight: 700;
            color: #00eaff;
            text-shadow: 0 0 10px #00eaff;
        }
        nav ul {
            list-style: none;
            display: flex;
        }
        nav ul li { margin-left: 30px; }
        nav ul li a {
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            transition: 0.3s;
            padding: 8px 16px;
            border-radius: 10px;
        }
        nav ul li a:hover {
            background: #00eaff;
            color: #000;
            box-shadow: 0 0 10px #00eaff;
        }

        /* === Hero Section === */
        .hero {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .bg-animation {
            position: absolute;
            width: 200%;
            height: 200%;
            background: linear-gradient(115deg, #001f3f, #001122, #003355, #00eaff);
            background-size: 400% 400%;
            animation: gradientMove 12s ease infinite;
            z-index: -1;
            filter: blur(150px);
        }
        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* === Rotating Shield Animation === */
        .shield-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin-bottom: 40px;
            perspective: 800px;
        }
        .shield {
            width: 100%;
            height: 100%;
            border: 3px solid #00eaff;
            border-radius: 50%;
            box-shadow: 0 0 30px #00eaff, inset 0 0 20px #00eaff;
            animation: rotateShield 6s linear infinite;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .shield i {
            font-size: 3rem;
            color: #00eaff;
            text-shadow: 0 0 15px #00eaff;
        }
        @keyframes rotateShield {
            0% { transform: rotateY(0deg) rotateX(0deg); }
            100% { transform: rotateY(360deg) rotateX(360deg); }
        }

        /* === Floating Particle Glow === */
        .particle {
            position: absolute;
            width: 6px;
            height: 6px;
            background: #00eaff;
            border-radius: 50%;
            opacity: 0.6;
            animation: floatParticles 8s linear infinite;
        }
        @keyframes floatParticles {
            from { transform: translateY(0) scale(1); opacity: 1; }
            to { transform: translateY(-100vh) scale(0.5); opacity: 0; }
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #00eaff;
            text-shadow: 0 0 20px #00eaff;
            animation: fadeInDown 1s ease;
        }
        .hero p {
            font-size: 1.2rem;
            color: #ccc;
            max-width: 750px;
            margin-bottom: 40px;
            animation: fadeInUp 1.4s ease;
        }

        .hero .btn-group a {
            display: inline-block;
            margin: 10px;
            padding: 12px 28px;
            font-weight: 600;
            border-radius: 50px;
            text-decoration: none;
            transition: 0.4s ease;
            border: 2px solid #00eaff;
        }
        .btn-admin {
            background: #00eaff;
            color: #000;
        }
        .btn-admin:hover {
            background: transparent;
            color: #00eaff;
            box-shadow: 0 0 15px #00eaff;
        }
        .btn-login {
            background: transparent;
            color: #00eaff;
        }
        .btn-login:hover {
            background: #00eaff;
            color: #000;
            box-shadow: 0 0 15px #00eaff;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* === Modules Section === */
        .modules {
            padding: 100px 60px;
            background: #0d1218;
            text-align: center;
        }
        .modules h2 {
            font-size: 2.4rem;
            margin-bottom: 50px;
            color: #00eaff;
            text-shadow: 0 0 15px #00eaff;
        }
        .module-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }
        .module-card {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 20px;
            padding: 35px 25px;
            transition: 0.4s;
            position: relative;
            overflow: hidden;
        }
        .module-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 0 25px rgba(0,234,255,0.3);
            border-color: #00eaff;
        }
        .module-card i {
            font-size: 2.8rem;
            color: #00eaff;
            margin-bottom: 18px;
        }
        .module-card h3 {
            color: #fff;
            margin-bottom: 12px;
        }
        .module-card p {
            color: #aaa;
            font-size: 0.95rem;
        }

        footer {
            background: #080b10;
            padding: 50px 30px;
            text-align: center;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        .socials a {
            color: #00eaff;
            font-size: 1.3rem;
            margin: 0 12px;
            transition: 0.3s;
        }
        .socials a:hover {
            color: #fff;
            text-shadow: 0 0 15px #00eaff;
        }
        footer p {
            margin-top: 15px;
            color: #999;
            font-size: 0.9rem;
        }

        @media(max-width:768px){
            header{padding:15px 30px;}
            .hero h1{font-size:2.2rem;}
            .modules{padding:60px 25px;}
        }
    </style>
</head>
<body>

<header>
    <div class="logo"><i class="fa-solid fa-shield-halved"></i> A.S.A.A System</div>
    <nav>
        <ul>
            <li><a href="admin.jsp">Admin</a></li>
            <li><a href="Signup.jsp">Sign Up</a></li>
            <li><a href="login.jsp">Login</a></li>
        </ul>
    </nav>
</header>

<section class="hero">
    <div class="bg-animation"></div>

    <!-- Rotating Shield Animation -->
    <div class="shield-container">
        <div class="shield"><i class="fa-solid fa-shield-halved"></i></div>
    </div>

    <!-- Random floating particles -->
    <div class="particle" style="left:10%; animation-delay:1s;"></div>
    <div class="particle" style="left:40%; animation-delay:2s;"></div>
    <div class="particle" style="left:70%; animation-delay:3s;"></div>
    <div class="particle" style="left:85%; animation-delay:4s;"></div>

    <h1>Automated Security Assessment & Approval System</h1>
    <p>Next-generation blockchain-powered framework for analyzing, assessing, and approving secured file requests with cryptographic integrity and AI-driven intelligence.</p>

    <div class="btn-group">
        <a href="admin.jsp" class="btn-admin">Admin Portal</a>
        <a href="login.jsp" class="btn-login">User Login</a>
    </div>
</section>

<section class="modules">
    <h2>System Modules</h2>
    <div class="module-grid">
        <div class="module-card">
            <i class="fa-solid fa-user-shield"></i>
            <h3>Utilizer Management</h3>
            <p>Manage registered utilizers with secure session tracking and identity-based access validation.</p>
        </div>
        <div class="module-card">
            <i class="fa-solid fa-upload"></i>
            <h3>File Upload & Integrity Check</h3>
            <p>Files are uploaded securely and verified using cryptographic hash validation techniques.</p>
        </div>
        <div class="module-card">
            <i class="fa-solid fa-diagram-project"></i>
            <h3>Graphical Security Models</h3>
            <p>Visualize access flow using real-time security graphs to monitor dependencies and trust levels.</p>
        </div>
        <div class="module-card">
            <i class="fa-solid fa-key"></i>
            <h3>Dynamic Key Handling</h3>
            <p>Keys are managed and exchanged securely using blockchain-driven smart contracts.</p>
        </div>
        <div class="module-card">
            <i class="fa-solid fa-microchip"></i>
            <h3>Automated Assessment</h3>
            <p>Leverage AI-powered risk models to automatically assess each file’s security status.</p>
        </div>
        <div class="module-card">
            <i class="fa-solid fa-chart-line"></i>
            <h3>Approval Analytics</h3>
            <p>Track and visualize system-wide approval and denial statistics with interactive dashboards.</p>
        </div>
    </div>
</section>

<footer>
    <div class="socials">
        <a href="#"><i class="fab fa-github"></i></a>
        <a href="#"><i class="fab fa-linkedin"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
    <p>© 2025 Automated Security Assessment System | Designed for Next-Gen Secure Data Governance</p>
</footer>

</body>
</html>
