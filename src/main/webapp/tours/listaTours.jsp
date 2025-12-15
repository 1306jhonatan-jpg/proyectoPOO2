<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.Explorapucallpa.beans.Tours"%>

<%
    String contextPath = request.getContextPath();
    List<Tours> lista = (List<Tours>) request.getAttribute("listaTours");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista de Tours</title>

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
<jsp:include page="/componentes/navbar.jsp" />

<div class="content-container">

        <h2 class="mb-4">
        <i class="fa-solid fa-route"></i> Gestión de Tours
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
    
    <!-- Botón Nuevo Usuario -->
    <button class="btn btn-success mb-3" onclick="modalTour.abrir('nuevo')">
        <i class="fas fa-plus"></i> Nuevo Tour
    </button>

    <!-- Tabla -->
    <div class="table-responsive">
<table class="table table-bordered table-striped table-hover">
        <thead class="table-success">
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-hashtag"></i> Tour</th>
                        <th><i class="fas fa-hashtag"></i> Descripcion</th>
                        <th><i class="fas fa-hashtag"></i> Servicios</th>
                        <th><i class="fas fa-hashtag"></i> Fecha Creacion</th>
                        <th><i class="fas fa-hashtag"></i> Duracion</th>
                        <th><i class="fas fa-hashtag"></i> Estado</th>
                        <th class="text-center"><i class="fas fa-cog"></i> Acciones</th>
                    </tr>
                </thead>
                <tbody>

                <% 
                List<Tours> listaTours = (List<Tours>) request.getAttribute("listaTours");
                if (listaTours != null && !listaTours.isEmpty()) {
                       for (Tours t : listaTours) { %>

                    <tr>
                        <td><%= t.getIdTours() %></td>
                        <td><%= t.getNombreTours() %></td>
                         <td><%= t.getDescripcion() %></td>
                          <td><%= t.getServicios() %></td>
                        <td><%= t.getFechaTours() %></td>
                        <td><%= t.getDuracionTours() %></td>

                        <td>
                            <span class="badge <%= "Activo".equalsIgnoreCase(t.getEstado()) 
                                ? "bg-success" : "bg-secondary" %>">
                                <%= t.getEstado() %>
                            </span>
                        </td>

                        <td class="text-center">

                            <a href="<%=contextPath%>/ToursController?op=editar&id=<%=t.getIdTours()%>"
                               class="btn btn-sm btn-warning">
                                <i class="fa fa-edit"></i>
                            </a>

                            <a href="<%=contextPath%>/ToursController?op=desactivar&id=<%=t.getIdTours()%>"
                               class="btn btn-sm btn-secondary"
                               onclick="return confirm('¿Desactivar este tour?')">
                                <i class="fa fa-ban"></i>
                            </a>

                            <a href="<%=contextPath%>/ToursController?op=eliminar&id=<%=t.getIdTours()%>"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('¿Eliminar este tour?')">
                                <i class="fa fa-trash"></i>
                            </a>

                        </td>
                    </tr>

                <%   }
                   } else { %>

                    <tr>
                        <td colspan="8" class="text-center text-muted">
                            No hay tours registrados
                        </td>
                    </tr>

                <% } %>

                </tbody>
            </table>
        </div>
    </div>

<!-- Modal -->
<div class="modal fade" id="modalTour" tabindex="-1"
	aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	 <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
            <h5 class="modal-title" id="modalTourLabel">
                    <i class="fas fa-user-edit"></i> Tour
                </h5>
                <button type="button" class="btn-close btn-close-white"
                    data-bs-dismiss="modal" id="btnCerrarModal"></button>
            </div>
                        <div class="modal-body">
                <div id="loadingSpinner" class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Cargando...</span>
                    </div>
                    <p class="mt-2 text-muted">Cargando formulario...</p>
                </div>

                <div id="mensajeModal" class="alert d-none" role="alert"></div>
                <div id="contenidoModal" style="display: none;"></div>
            </div>
        </div>
    </div>
   </div>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"></script>
</body>
</html>
