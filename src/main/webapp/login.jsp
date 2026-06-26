<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Sign Up | ASAA System</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
/* --- Global --- */
*{margin:0;padding:0;box-sizing:border-box;font-family:'Inter',sans-serif;}
html, body{height:100%; width:100%; transition: all 0.5s ease; overflow-x:hidden;}

/* --- Background Layers --- */
.bg-layer{
    position:fixed; width:100%; height:100%; top:0; left:0; z-index:-1;
    transition: background 0.5s ease;
}
.bg-layer.layer1, .bg-layer.layer2, .bg-layer.layer3{animation:animateBg 25s infinite alternate linear;}
.bg-layer.layer1{background:radial-gradient(circle at 20% 20%, rgba(0,216,255,0.15), transparent);}
.bg-layer.layer2{background:radial-gradient(circle at 80% 80%, rgba(255,0,200,0.1), transparent);}
.bg-layer.layer3{background:linear-gradient(135deg, rgba(0,255,200,0.05), rgba(255,255,255,0.03)); mix-blend-mode:overlay;}
@keyframes animateBg{
    0%{transform:translateY(0) translateX(0);}
    50%{transform:translateY(25px) translateX(25px);}
    100%{transform:translateY(-25px) translateX(-25px);}
}

/* --- Header --- */
header{
    width:100%; padding:20px 50px; display:flex; justify-content:space-between; align-items:center;
    position:fixed; top:0; z-index:100; backdrop-filter:blur(12px); border-bottom:1px solid rgba(255,255,255,0.1);
    transition:all 0.5s ease;
}
header .logo{font-size:1.8rem; color:#00d8ff; font-weight:700; display:flex; align-items:center; gap:10px;}
nav ul{display:flex; list-style:none;}
nav ul li{margin-left:30px;}
nav ul li a{color:white; text-decoration:none; font-weight:500; padding:8px 15px; border-radius:6px; transition:0.3s;}
nav ul li a:hover{background:#00d8ff;color:black;}

/* --- Container --- */
.container{display:flex; min-height:100vh; width:100%; padding-top:80px;}
.left-panel, .right-panel{flex:1; display:flex; justify-content:center; align-items:center; padding:50px; transition:all 0.5s ease;}
.left-panel{flex-direction:column; text-align:center;}
.left-panel h1{font-size:2.8rem; margin-bottom:20px;}
.left-panel p{max-width:400px; margin-bottom:30px; line-height:1.5;}
.left-panel button{padding:12px 25px; border:none; border-radius:8px; font-weight:600; cursor:pointer; transition:0.3s;}
.left-panel button:hover{transform:translateY(-3px); box-shadow:0 0 20px currentColor;}

.right-panel{justify-content:center;}
.signup-card{width:100%; max-width:400px; padding:40px; border-radius:20px; box-shadow:0 0 50px rgba(0,216,255,0.3); backdrop-filter:blur(10px); transition:all 0.5s ease;}
.signup-card:hover{transform:translateY(-5px); box-shadow:0 0 60px rgba(0,216,255,0.5);}
.signup-card h2{margin-bottom:25px;}
.signup-card form{display:flex; flex-direction:column; gap:20px;}
.signup-card input, .signup-card select{width:100%; padding:12px 15px; border:none; border-radius:8px; outline:none; font-size:1rem; transition:0.3s;}
.signup-card input:focus, .signup-card select:focus{box-shadow:0 0 12px currentColor;}
.signup-card button{padding:12px; border:none; border-radius:8px; font-weight:600; cursor:pointer; transition:0.3s;}
.signup-card button:hover{transform:translateY(-2px); box-shadow:0 0 25px currentColor;}
.signup-card p{color:#ccc; margin-top:10px; font-size:0.9rem;}
.signup-card p a{text-decoration:none;}
.signup-card p a:hover{text-decoration:underline;}

/* --- Footer --- */
footer{background:#070b10;color:#999;text-align:center;padding:25px 0;font-size:0.9rem; transition:all 0.5s ease;}
footer .socials a{margin:0 10px;font-size:1.2rem; transition:0.3s;}
footer .socials a:hover{color:white;}

/* --- Theme 1 --- */
body.theme1{background:#0a0f1e;}
body.theme1 .bg-layer.layer1{background:radial-gradient(circle at 20% 20%, rgba(0,216,255,0.15), transparent);}
body.theme1 .bg-layer.layer2{background:radial-gradient(circle at 80% 80%, rgba(255,0,200,0.1), transparent);}
body.theme1 .bg-layer.layer3{background:linear-gradient(135deg, rgba(0,255,200,0.05), rgba(255,255,255,0.03));}
body.theme1 header{background:rgba(0,0,0,0.5);}
body.theme1 .left-panel{background:rgba(255,255,255,0.05); color:white;}
body.theme1 .signup-card{background:rgba(0,0,0,0.7); color:white;}
body.theme1 footer{background:#070b10;}

/* --- Theme 2 --- */
body.theme2{background:#1e1a2b;}
body.theme2 .bg-layer.layer1{background:radial-gradient(circle at 20% 20%, rgba(255,102,0,0.2), transparent);}
body.theme2 .bg-layer.layer2{background:radial-gradient(circle at 80% 80%, rgba(0,255,221,0.15), transparent);}
body.theme2 .bg-layer.layer3{background:linear-gradient(135deg, rgba(255,0,170,0.05), rgba(255,0,102,0.03));}
body.theme2 header{background:rgba(10,10,20,0.7);}
body.theme2 .left-panel{background:rgba(255,255,255,0.1); color:white;}
body.theme2 .signup-card{background:rgba(20,20,30,0.8); color:white;}
body.theme2 footer{background:#11101a;}
</style>
</head>
<body class="theme1">

<!-- Background Layers -->
<div class="bg-layer layer1"></div>
<div class="bg-layer layer2"></div>
<div class="bg-layer layer3"></div>

<header>
    <div class="logo"><i class="fa-solid fa-shield-halved"></i> ASAA System</div>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="Signup.jsp">Sign Up</a></li>
            <li><a href="login.jsp">Login</a></li>
        </ul>
    </nav>
</header>

<!-- Theme Toggle -->
<div style="position:fixed;top:20px;right:20px;z-index:200;">
    <button id="themeBtn" style="padding:10px 15px;border:none;border-radius:8px;background:#00d8ff;color:#fff;cursor:pointer;">Switch Theme</button>
</div>

<div class="container">
    <div class="left-panel">
        <h1>Welcome to ASAA System</h1>
        <p>Register to manage your secure file operations and blockchain-based approvals with real-time monitoring.</p>
        <button onclick="window.location.href='Signup.jsp'" style="color:#00d8ff;">New User? Sign Up</button>
    </div>
    <div class="right-panel">
        <div class="signup-card">
            <h2> Login </h2>




            <form action="UserLogin" method="post">
                <input type="text" name="username" placeholder="Username" required>
               
                <input type="password" name="password" placeholder="Password" required>
                
                <button type="submit">Login</button>
            </form>
        </div>
    </div>
</div>

<footer>
    <div class="socials">
        <a href="#"><i class="fab fa-github"></i></a>
        <a href="#"><i class="fab fa-linkedin"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
    <p>© 2025 Automated Security Assessment & Approval System</p>
</footer>

<script>
    const themeBtn = document.getElementById('themeBtn');
    themeBtn.addEventListener('click', ()=>{
        document.body.classList.toggle('theme1');
        document.body.classList.toggle('theme2');
    });
</script>

</body>
</html>
