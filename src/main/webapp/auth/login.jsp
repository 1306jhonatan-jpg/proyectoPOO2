<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String url = request.getContextPath() + "/";
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Iniciar Sesión - Explora Pucallpa</title>

<style>

/* 🌴 FONDO DE SELVA SUAVE REALISTA */
body {
    background: url("<%=url%>img/fondo_selva.png") no-repeat center center fixed;
    background-size: cover;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    margin: 0;
    font-family: 'Poppins', sans-serif;
}

/* Capa oscura para hacer contraste con el login */
body::before {
    content: "";
    position: absolute;
    inset: 0;
    background: rgba(0,0,0,0.5);
    backdrop-filter: blur(1.5px);
}

/* Contenedor principal centrado */
.login-container {
    position: relative;
    max-width: 480px;
    width: 100%;
    z-index: 10;
}

/* Tarjeta con estilo selvático translúcido */
.login-card {
    background: rgba(255, 255, 255, 0.12);
    border-radius: 20px;
    padding-bottom: 10px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.5);
    backdrop-filter: blur(7px);
    border: 2px solid rgba(255,255,255,0.2);
    overflow: hidden;
}

/* Encabezado */
.login-header {
    text-align: center;
    padding: 25px;
    background: rgba(20, 90, 35, 0.85);
    border-bottom: 3px solid #4caf50;
}

.login-header img {
    width: 180px;
    margin-bottom: 5px;
}

.login-header h3 {
    color: #ffee58;
    margin: 0;
    font-weight: 700;
    text-shadow: 1px 1px 5px black;
}

.login-header p {
    color: #eaffea;
    margin-top: 5px;
}

/* Cuerpo */
.login-body {
    padding: 35px;
    color: white;
}

/* Inputs */
.input-group-text {
    background-color: #1b5e20;
    color: #fdd835;
    border-right: none;
    border: 1px solid #4caf50;
}

.form-control {
    background: rgba(255, 255, 255, 0.12);
    border: 1px solid #4caf50;
    border-left: none;
    color: #e8ffe8;
}

.form-control::placeholder {
    color: #c8ffcf;
}

/* Botón */
.btn-login {
    background: linear-gradient(135deg, #4caf50, #2e7d32);
    border: none;
    padding: 12px;
    color: #fff;
    font-weight: 600;
    border-radius: 10px;
    transition: 0.2s;
}

.btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 20px rgba(76, 175, 80, 0.5);
}

/* Mostrar/ocultar contraseña */
#togglePassword {
    background-color: #1b5e20;
    color: #fdd835;
    border: none;
}

/* Footer */
.footer {
    text-align: center;
    color: #e0ffe2;
    margin-top: 10px;
}



/* Quitar sombra azul default de Bootstrap */
.form-control:focus {
    border-color: #4caf50 !important;
    box-shadow: 0 0 0 0.25rem rgba(76, 175, 80, 0.35) !important; /* Verde suave */
    background-color: rgba(255, 255, 255, 0.18) !important;
    color: #e8ffe8 !important;
}

/* Mantener el color del label siempre */
.form-label {
    color: #fdd835 !important;  /* Amarillo selva */
}

</style>

</head>

<body>

<div class="login-container">
    <div class="login-card">

        <!-- Logo + título -->
        <div class="login-header">
            <img src="<%=url%>img/logo_selva (1).png">
            <h3>Agencia de Viajes y Turismo</h3>
        </div>

        <div class="login-body">

            <!-- Mostrar errores -->
            <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> <%=error%>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <!-- Formulario -->
            <form action="<%=url%>LoginController" method="POST" id="formLogin">
                <input type="hidden" name="accion" value="login">

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-user"></i> Usuario</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" id="usuario" name="usuario"
                               class="form-control" placeholder="Nombre de usuario" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label"><i class="fas fa-lock"></i> Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" id="password" name="password"
                               class="form-control" placeholder="Contraseña" required>
                        <button class="btn" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn btn-login w-100">
                    <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                </button>
            </form>

        </div>
    </div>

    <div class="footer">
        <small>&copy; 2025 Explora Pucallpa - Todos los derechos reservados</small>
    </div>
</div>

<script>
// Mostrar/Ocultar contraseña
document.getElementById("togglePassword").addEventListener("click", function () {
    const input = document.getElementById("password");
    const icon = this.querySelector("i");

    input.type = input.type === "password" ? "text" : "password";
    icon.classList.toggle("fa-eye");
    icon.classList.toggle("fa-eye-slash");
});
</script>

</body>
</html>
