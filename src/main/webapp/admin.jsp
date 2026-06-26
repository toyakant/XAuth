<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Portal | Automated Security Assessment System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        * {margin:0; padding:0; box-sizing:border-box; font-family:'Poppins',sans-serif;}

        body {
            color:#fff;
            background:#0b1522;
            overflow-x:hidden;
            position:relative;
        }

        /* --- Canvas Background --- */
        #bgCanvas {
            position:fixed;
            top:0; left:0;
            width:100%; height:100%;
            z-index:-2;
        }

        /* --- Header --- */
        header {
            width:100%;
            padding:15px 60px;
            background:rgba(0,0,0,0.5);
            backdrop-filter:blur(12px);
            display:flex;
            justify-content:space-between;
            align-items:center;
            position:fixed;
            top:0;
            z-index:100;
            border-bottom:1px solid rgba(255,255,255,0.1);
        }
        header .logo {
            font-size:1.6rem;
            font-weight:700;
            color:#00d8ff;
            display:flex; align-items:center; gap:10px;
        }
        header nav ul {
            display:flex; list-style:none;
        }
        header nav ul li {margin-left:30px;}
        header nav ul li a {
            color:white; text-decoration:none;
            font-weight:500;
            padding:8px 15px; border-radius:6px;
            transition:0.3s;
        }
        header nav ul li a:hover {background:#00d8ff; color:black;}

        /* --- Hero Section --- */
        .hero {
            min-height:100vh;
            display:flex;
            flex-direction:column;
            justify-content:center;
            align-items:center;
            text-align:center;
            padding-top:100px;
            position:relative;
            z-index:1;
        }
        .hero h1 {
            font-size:3rem;
            color:#00d8ff;
            margin-bottom:15px;
            text-shadow: 0 0 10px #00d8ff, 0 0 20px #00d8ff;
        }
        .hero p {
            max-width:700px;
            color:#ccc;
            font-size:1.1rem;
        }

        .divider {
            width:80px; height:4px; background:#00d8ff;
            margin:40px auto;
            border-radius:4px;
        }

        /* --- Login Section --- */
        .login-section {
            min-height:90vh;
            display:flex;
            justify-content:center;
            align-items:center;
            padding:80px 20px;
            position:relative;
            z-index:1;
        }
        .login-container {
            width:380px;
            background:rgba(0,0,0,0.7);
            border:1px solid rgba(0,216,255,0.3);
            border-radius:20px;
            padding:40px;
            text-align:center;
            box-shadow:0 0 60px rgba(0,216,255,0.3);
            backdrop-filter:blur(20px);
            transition:0.3s;
        }
        .login-container:hover {
            transform:translateY(-10px);
            box-shadow:0 0 80px rgba(0,216,255,0.5);
        }
        .login-container h2 {margin-bottom:25px; color:#00d8ff; font-size:1.8rem;}
        .input-box {margin-bottom:25px; position:relative;}
        .input-box input {
            width:100%; padding:12px 15px;
            background:rgba(255,255,255,0.1);
            border:none; border-radius:8px;
            color:white; outline:none; font-size:0.95rem;
            transition:0.3s;
        }
        .input-box input:focus {background:rgba(255,255,255,0.2);}
        .input-box i {position:absolute; right:15px; top:50%; transform:translateY(-50%); color:#aaa; cursor:pointer;}
        .btn {
            width:100%; padding:12px;
            border:none; border-radius:8px;
            background:linear-gradient(90deg,#00d8ff,#0072ff);
            color:white; font-weight:600; cursor:pointer;
            transition:0.3s;
        }
        .btn:hover {box-shadow:0 0 25px #00d8ff; transform:translateY(-2px);}

        /* --- Info Section --- */
        .info {padding:80px 60px; background:#0c131d; text-align:center; position:relative; z-index:1;}
        .info h2 {color:#00d8ff; font-size:2rem; margin-bottom:20px;}
        .info p {max-width:800px; margin:auto; color:#bbb; line-height:1.7;}

        /* --- Footer --- */
        footer {background:#070b10; color:#999; text-align:center; padding:25px 0; font-size:0.9rem; position:relative; z-index:1;}
        footer .socials a {color:#00d8ff; margin:0 10px; font-size:1.2rem; transition:0.3s;}
        footer .socials a:hover {color:white;}

        @media(max-width:768px){
            header {padding:15px 25px;}
            .hero h1 {font-size:2rem;}
            .login-container {width:300px;}
        }
    </style>
</head>
<body>

<!-- Animated Network Canvas -->
<canvas id="bgCanvas"></canvas>

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

<section class="hero">
    <h1>Welcome to the Admin Security Portal</h1>
    <p>Manage and approve file requests with blockchain-backed integrity and automated risk analysis.
       Gain real-time visibility into file activity, access logs, and cryptographic verifications.</p>
    <div class="divider"></div>
</section>

<section class="login-section">
    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="post">
            <div class="input-box">
                <input type="text" name="username" placeholder="Enter Username" required>
                <i class="fa-solid fa-user"></i>
            </div>
            <div class="input-box">
                <input type="password" id="password" name="password" placeholder="Enter Password" required>
                <i class="fa-solid fa-eye" id="togglePassword"></i>
            </div>
            <input type="submit" value="Login" class="btn">
        </form>
        <div class="msg">
            <% if (request.getParameter("msg") != null) { %>
                <%= request.getParameter("msg") %>
            <% } %>
        </div>
    </div>
</section>

<section class="info">
    <h2>Why Admin Access is Critical</h2>
    <p>The admin portal in this system is designed for transparency and governance. 
       Each admin action triggers a smart contract update and logs activity securely across the blockchain layers. 
       This ensures that no unauthorized access can occur and every operation is cryptographically verified.</p>
</section>

<footer>
    <div class="socials">
        <a href="#"><i class="fab fa-github"></i></a>
        <a href="#"><i class="fab fa-linkedin"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
    </div>
    <p>© 2025 Automated Security Assessment & Approval System | Secure Admin Environment</p>
</footer>

<script>
    // Password toggle
    const togglePassword = document.getElementById('togglePassword');
    const password = document.getElementById('password');
    togglePassword.addEventListener('click', () => {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        togglePassword.classList.toggle('fa-eye-slash');
    });

    // --- Animated Network Background ---
    const canvas = document.getElementById('bgCanvas');
    const ctx = canvas.getContext('2d');
    let w, h;
    const nodes = [];
    const nodeCount = 50;
    const maxDistance = 150;

    function resizeCanvas() {
        w = canvas.width = window.innerWidth;
        h = canvas.height = window.innerHeight;
    }
    window.addEventListener('resize', resizeCanvas);
    resizeCanvas();

    // Node class
    class Node {
        constructor() {
            this.x = Math.random()*w;
            this.y = Math.random()*h;
            this.vx = (Math.random()-0.5)*0.3;
            this.vy = (Math.random()-0.5)*0.3;
            this.radius = 2 + Math.random()*3;
        }
        update() {
            this.x += this.vx;
            this.y += this.vy;
            if(this.x<0||this.x>w) this.vx*=-1;
            if(this.y<0||this.y>h) this.vy*=-1;
        }
        draw() {
            ctx.beginPath();
            ctx.arc(this.x,this.y,this.radius,0,Math.PI*2);
            ctx.fillStyle='rgba(0,216,255,0.7)';
            ctx.fill();
        }
    }

    for(let i=0;i<nodeCount;i++){
        nodes.push(new Node());
    }

    function animate() {
        ctx.clearRect(0,0,w,h);
        for(let i=0;i<nodes.length;i++){
            nodes[i].update();
            nodes[i].draw();
            for(let j=i+1;j<nodes.length;j++){
                let dx = nodes[i].x - nodes[j].x;
                let dy = nodes[i].y - nodes[j].y;
                let dist = Math.sqrt(dx*dx+dy*dy);
                if(dist<maxDistance){
                    ctx.beginPath();
                    ctx.strokeStyle = `rgba(0,216,255,${1 - dist/maxDistance})`;
                    ctx.lineWidth=1;
                    ctx.moveTo(nodes[i].x,nodes[i].y);
                    ctx.lineTo(nodes[j].x,nodes[j].y);
                    ctx.stroke();
                }
            }
        }
        requestAnimationFrame(animate);
    }
    animate();
</script>

</body>
</html>
