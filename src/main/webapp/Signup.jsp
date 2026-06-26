<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Sign Up | Automated Security Assessment System</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
    body{background:#0b1522;color:white;overflow-x:hidden;}

    /* --- Layered animated background --- */
    .layer{position:fixed;top:0;left:0;width:100%;height:100%;z-index:-1;}
    .layer1{background:radial-gradient(circle at 20% 20%, rgba(0,255,255,0.15), transparent 70%);}
    .layer2{background:radial-gradient(circle at 80% 80%, rgba(0,100,255,0.1), transparent 70%);}
    .layer3{background:linear-gradient(135deg,rgba(0,200,255,0.05) 0%,rgba(255,255,255,0.03) 100%);
        mix-blend-mode:overlay;
        animation:moveBg 15s infinite linear alternate;}
    @keyframes moveBg {0%{transform:translateY(0);}100%{transform:translateY(-20px);}}

    /* --- Header --- */
    header{
        width:100%; padding:15px 50px;
        display:flex; justify-content:space-between; align-items:center;
        backdrop-filter:blur(12px); background:rgba(0,0,0,0.5);
        position:fixed; top:0; z-index:100; border-bottom:1px solid rgba(255,255,255,0.1);
    }
    header .logo{font-size:1.6rem;font-weight:700;color:#00d8ff;display:flex;align-items:center;gap:10px;}
    header nav ul{display:flex; list-style:none;}
    header nav ul li{margin-left:30px;}
    header nav ul li a{color:white;text-decoration:none;font-weight:500;padding:8px 15px;border-radius:6px;transition:0.3s;}
    header nav ul li a:hover{background:#00d8ff;color:black;}

    /* --- Hero Section --- */
    .hero{min-height:70vh; display:flex; flex-direction:column; justify-content:center; align-items:center; text-align:center; padding-top:100px;}
    .hero h1{font-size:2.8rem;color:#00d8ff;margin-bottom:15px;}
    .hero p{max-width:700px;color:#ccc;font-size:1.1rem;margin-bottom:20px;}
    .hero .hero-btn{padding:12px 25px;background:linear-gradient(90deg,#00d8ff,#0072ff);color:white;border:none;border-radius:8px;cursor:pointer;font-weight:600;transition:0.3s;}
    .hero .hero-btn:hover{transform:translateY(-3px); box-shadow:0 0 20px #00d8ff;}

    /* --- Signup Section --- */
    .signup-section{min-height:90vh; display:flex; justify-content:center; align-items:center; padding:80px 20px; position:relative;}
    .signup-container{width:400px; background:rgba(0,0,0,0.6); border:1px solid rgba(255,255,255,0.1); border-radius:20px; padding:40px; text-align:center; box-shadow:0 0 60px rgba(0,216,255,0.3); backdrop-filter:blur(20px); transition:0.3s;}
    .signup-container:hover{transform:translateY(-8px); box-shadow:0 0 80px rgba(0,216,255,0.5);}
    .signup-container h2{margin-bottom:25px;color:#00d8ff;}
    .signup-container form{display:flex; flex-direction:column; gap:20px;}
    .signup-container input, .signup-container select, .signup-container button{width:100%; padding:12px 15px; border:none; border-radius:8px; font-size:1rem; outline:none; transition:0.3s;}
    .signup-container input, .signup-container select{background:rgba(255,255,255,0.15); color:white;}
    .signup-container input:focus, .signup-container select:focus{background:rgba(255,255,255,0.25); box-shadow:0 0 10px #00d8ff;}
    .signup-container button{background:linear-gradient(90deg,#00d8ff,#0072ff); color:white; font-weight:600; cursor:pointer;}
    .signup-container button:hover{box-shadow:0 0 25px #00d8ff; transform:translateY(-2px);}

    /* --- Info Section --- */
    .info{padding:80px 60px; text-align:center; background:rgba(255,255,255,0.02);}
    .info h2{color:#00d8ff;font-size:2rem;margin-bottom:20px;}
    .info p{max-width:800px;margin:auto;color:#ccc;line-height:1.7;}

    /* --- Footer --- */
    footer{background:#070b10;color:#999;text-align:center;padding:25px 0;font-size:0.9rem;}
    footer .socials a{color:#00d8ff;margin:0 10px;font-size:1.2rem;transition:0.3s;}
    footer .socials a:hover{color:white;}

    @media(max-width:768px){
        header{padding:15px 25px;}
        .hero h1{font-size:2rem;}
        .signup-container{width:90%;padding:30px;}
        .info{padding:60px 30px;}
    }
</style>
</head>
<body>

<!-- Background Layers -->
<div class="layer layer1"></div>
<div class="layer layer2"></div>
<div class="layer layer3"></div>

<header>
    <div class="logo"><i class="fa-solid fa-shield-halved"></i> A.S.A.A System</div>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="Signup.jsp">Sign Up</a></li>
            <li><a href="login.jsp">User Login</a></li>
        </ul>
    </nav>
</header>

<!-- Hero Section -->
<section class="hero">
    <h1>Welcome to ASAA System</h1>
    <p>Automated Security Assessment and Approval System ensures secure and efficient file management for Data Owners and Researchers.</p>
    <button class="hero-btn" onclick="document.getElementById('signup').scrollIntoView({behavior:'smooth'});">Register Now</button>
</section>

<!-- Signup Section -->
<section class="signup-section" id="signup">
    <div class="signup-container">
        <h2>Create Account</h2>
        <form action="RegisterServlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <select name="role" required>
                <option value="" disabled selected>Select Role</option>
                <option value="OWNER">Data Owner</option>
                <option value="RESEARCHER">Researcher</option>
            </select>
            <button type="submit">Register</button>
        </form>
    </div>
</section>

<!-- Info Section -->
<section class="info">
    <h2>Why Join ASAA System?</h2>
    <p>
        Our system provides full transparency, blockchain-backed integrity, and automated risk assessment for file requests. 
        Each action is logged securely, ensuring only authorized access with cryptographic verification.
    </p>
</section>

<!-- Footer Section -->
<footer>
    <div class="socials">
        <a href="#"><i class="fab fa-github"></i></a>
        <a href="#"><i class="fab fa-linkedin"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
    <p>© 2025 Automated Security Assessment & Approval System | Secure Admin Environment</p>
</footer>

</body>
</html>
