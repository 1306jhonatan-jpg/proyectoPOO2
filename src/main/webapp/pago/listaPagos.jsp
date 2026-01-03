<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Explorapucallpa.beans.Pago" %>

<%
String url = request.getContextPath();
List<Pago> lista = (List<Pago>) request.getAttribute("listaPagos");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestion Pagos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
    crossorigin="anonymous">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
body {
    background-image: url("<%=request.getContextPath()%>/img/fondo.png"); 
    background-size: cover;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;
}
.content-container {
    margin-left: 260px; /* se ajusta al ancho del sidebar */
    padding: 25px;
    
    border-radius: 12px;
    min-height: 90vh;
}
</style>
<style>
tbody tr:hover{
    background-color: rgba(0,150,50,0.15);
    cursor:pointer;
}

.btnSelva{
    background:#2e7d32;
    color:white;
}

.btnSelva:hover{
    background:#25612a;
}
</style>

</head>
<body>
<!-- Navbar -->
<jsp:include page="/componentes/navbar.jsp"/>

<div class="content-container">
    
    <h2 class="text-center" class="mb-4">
        <i class="fas fa-user-shield"></i> Listado de Pagos
    </h2>

    <!-- Mensajes de sesión -->
    <%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
    %>
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <i class="fas fa-info-circle"></i>
        <%=mensaje%>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <%
    session.removeAttribute("mensaje");
    }
    %>

	<div class="table-responsive">
    <table class="table table-bordered table-striped table-hover">
        <thead class="table-success">
            <tr>
                <th><i class="fas fa-hashtag"></i> ID</th>
                <th><i class="fas fa-user"></i> Metodo de pago</th>
                <th><i class="fas fa-id-card"></i> estado de pago</th>

            </tr>
        </thead>

        <tbody>
        <% 
        List<Pago> listaPagos = (List<Pago>) request.getAttribute("listaPagos");
        if(listaPagos != null && !listaPagos.isEmpty()) { 
            for(Pago p : listaPagos){ %>
            <tr>
                <td><code><%=p.getIdpago()%></code></td>
                <td><strong><%= p.getMetodoPago()%></strong></td>
                <td><%=p.getEstadoPago()%></td>
            </tr>
        <% } 
           } else{%>
           <tr>
                    <td colspan="7" class="text-center text-muted">
                        <i class="fas fa-inbox"></i> No hay Pagos registrados
                    </td>
                </tr>
                <%
                }
                %>
        </tbody>
    </table>
</div>
</div>
</head>
<body>

</body>
</html>