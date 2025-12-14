<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.Explorapucallpa.beans.Usuario"%>
<%
String currentUrl = request.getRequestURI();
String contextPath = request.getContextPath();

String nombreUsuario = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
Integer idUsuarioLogueado = (Integer) session.getAttribute("idUsuario");
boolean esAdmin = "ADMIN".equalsIgnoreCase(rol);

if(nombreUsuario == null) {
    response.sendRedirect(contextPath + "/LoginController");
    return;
}
%>

<style>
    /* Contenedor del navbar vertical */
    .sidebar {
        width: 250px;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        background: #0f421b;
        padding: 20px 15px;
        color: white;
        box-shadow: 4px 0px 10px rgba(0,0,0,0.4);
    }

    .sidebar-title {
        text-align: center;
        font-size: 22px;
        margin-bottom: 10px;
        font-weight: bold;
    }

    .logo-wrapper {
        text-align: center;
        margin-bottom: 10px;
    }

    .logo-img {
        width: 140px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.25);
    }

    .sidebar .nav-item {
        margin-bottom: 12px;
    }

    .sidebar a {
        display: block;
        text-decoration: none;
        font-size: 17px;
        padding: 10px 14px;
        color: #ffffff;
        border-radius: 6px;
        transition: 0.2s;
    }

    .sidebar a i {
        margin-right: 8px;
    }

    .sidebar a:hover {
        background: rgba(255, 255, 255, 0.15);
    }

    .active {
        background: rgba(255,255,255,0.25) !important;
        font-weight: bold;
    }

    /* Usuario al final */
    .user-box {
        background: #144f26;
        border-radius: 8px;
        padding: 12px;
        position: absolute;
        bottom: 20px;
        left: 15px;
        right: 15px;
        text-align: center;
        cursor: pointer;
    }

    .user-box:hover {
        background: #1b6a33;
    }

    .dropdown-menu-vertical {
        position: absolute;
        bottom: 70px;
        left: 15px;
        right: 15px;
        background: #144f26;
        border-radius: 8px;
        display: none;
        padding: 8px 0;
    }

    .dropdown-menu-vertical a {
        padding: 10px;
        text-align: left;
        display: block;
    }

    .dropdown-menu-vertical a:hover {
        background: #1b6a33;
    }

    .badge-admin {
        background: #FFC107;
        color: black;
        font-size: 12px;
        padding: 3px 5px;
        border-radius: 4px;
        margin-left: 5px;
    }
</style>

<div class="sidebar">

    <!-- LOGO: usando la imagen subida -->
    <div class="logo-wrapper">
        <img class="logo-img" src="<%=contextPath%>/img/logo_selva (1).png" alt="Explora Pucallpa">
    </div>

    <div class="sidebar-title">
        Explora Pucallpa
    </div>

    <!-- Botones del menú -->
    <div class="nav-item">
        <a class="<%= currentUrl.contains("inicio") ? "active" : "" %>" 
           href="<%=contextPath%>/inicio.jsp">
           <i class="fas fa-home"></i> Inicio
        </a>
    </div>

    <div class="nav-item">
        <a class="<%= currentUrl.toLowerCase().contains("reserva") ? "active" : "" %>"
           href="<%=contextPath%>/listaGuias.jsp">
           <i class="fas fa-calendar-check"></i> Reserva
        </a>
    </div>

    <div class="nav-item">
        <a class="<%= currentUrl.toLowerCase().contains("tours") ? "active" : "" %>"
           href="<%=contextPath%>/tours.jsp">
           <i class="fas fa-map-marked-alt"></i> Tours
        </a>
    </div>

    <div class="nav-item">
        <a class="<%= currentUrl.toLowerCase().contains("clientes") ? "active" : "" %>"
           href="<%=contextPath%>/clientes.jsp">
           <i class="fas fa-users"></i> Clientes
        </a>
    </div>
    
        <div class="nav-item">
        <a class="<%= currentUrl.toLowerCase().contains("guias") ? "active" : "" %>"
           href="<%=contextPath%>/GuiasController?op=listar">
           <i class="fas fa-user"></i> Guias
        </a>
    </div>

    <% if(esAdmin) { %>
    <div class="nav-item">
        <a class="<%= currentUrl.toLowerCase().contains("reportes") ? "active" : "" %>"
           href="<%=contextPath%>/reportes.jsp">
           <i class="fas fa-chart-line"></i> Reportes
        </a>
    </div>
    <% } %>

    <!-- Usuario al final -->
    <div class="user-box" onclick="toggleUserMenu()">
        <i class="fas fa-user-circle"></i> <%= nombreUsuario %>
        <% if(esAdmin){ %>
            <span class="badge-admin">Admin</span>
        <% } else {%>
        <span class="badge-admin">Usuario</span>
        <%} %>
    </div>

    <div id="userMenu" class="dropdown-menu-vertical" aria-hidden="true">
        <a href="<%=contextPath%>/UsuariosController?op=listar"><i class="fas fa-user"></i> Mi Perfil</a>
        <a onclick="modalUsuario.abrir('cambiarPassword', <%=idUsuarioLogueado%>)"><i class="fas fa-key"></i> Cambiar Contraseña</a>
        <a class="text-danger" href="<%=contextPath%>/LoginController?accion=logout">
            <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
        </a>
    </div>
</div>

<script>
function toggleUserMenu() {
    let menu = document.getElementById("userMenu");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}
</script>
