<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.Explorapucallpa.beans.Reserva"%>

<% 
	String contextPath = request.getContextPath();
	List<Reserva> lista = (List<Reserva>) request.getAttribute("listaReservas");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista de Reservas</title>
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

        <h2 class="text-center" class="mb-4">
        <i class="fa-solid fa-calendar"></i> Gestión de Reservas
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
    <button class="btn btn-success mb-3" onclick="modalReserva.abrir('nuevo')">
        <i class="fas fa-plus"></i> Nueva Reserva
    </button>
    
        <!-- Tabla -->
    <div class="table-responsive">
<table class="table table-bordered table-striped table-hover">
        <thead class="table-success">
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-route"></i> Cantidad de Adultos</th>
                        <th><i class="fas fa-align-left"></i> Cantidad de Niños</th>
                        <th><i class="fas fa-concierge-bell"></i> Fecha de Reserva</th>
                        <th><i class="fas fa-clock"></i> Precio Adulto</th>
                        <th><i class="fas fa-toggle-on"></i> Precio Niño</th>
                        <th><i class="fas fa-calendar-days"></i> Total a pagar</th>
                        <th><i class="fas fa-calendar-days"></i> Tour</th>
                        <th><i class="fas fa-calendar-days"></i> Guia</th>
                        <th><i class="fas fa-calendar-days"></i> metodo de pago</th>
                        <th><i class="fas fa-calendar-days"></i> Cliente a cargo</th>
                        <th class="text-center"><i class="fas fa-cog"></i> Acciones</th>
                    </tr>
                </thead>
                <tbody>

                <% 
                List<Reserva> listaReservas = (List<Reserva>) request.getAttribute("listaReservas");
                if (listaReservas != null && !listaReservas.isEmpty()) {
                       for (Reserva r : listaReservas) { %>

                    <tr>
                        <td><code><%= r.getIdreserva() %></code></td>
                        <td><strong><%= r.getCantidadAdulto() %></strong></td>
                        <td><strong><%= r.getCantidadNino() %></strong></td>
                         <td><%= r.getFechaReserva() %></td>
                          <td><%= r.getPrecioAdulto() %></td>
                          <td><%= r.getPrecioNino() %></td>
                          <td><%= r.getTotalReserva() %></td>
                          <td><%= r.getToursIdtours() %></td>
                          <td><%= r.getGuiaIdguia() %></td>
                        <td><%= r.getPagoIdpago() %></td>
                        <td><%= r.getClienteIdcliente() %></td>

                        <td class="text-center">

                            <button class="btn btn-warning btn-sm"
                            onclick="modalReserva.abrir('editar',<%=r.getIdreserva()%>)"
                            title="Modificar Reserva">
                        <i class="fa fa-edit"></i>
                    </button>
                            <button class="btn btn-danger btn-sm"
                            onclick="eliminar(<%=r.getIdreserva()%>)"
                            title="Eliminar Reserva">
                        <i class="fa fa-trash"></i>
                    </button>

                        </td>
                    </tr>

                <%   }
                   } else { %>

                    <tr>
                        <td colspan="12" class="text-center text-muted">
                            No hay Reservas registrados
                        </td>
                    </tr>

                <% } %>

                </tbody>
            </table>
        </div>
</div>
<!-- Modal -->
<div class="modal fade" id="modalReserva" tabindex="-1"
	aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	 <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
            <h5 class="modal-title" id="modalReservaLabel">
                    <i class="fas fa-user-edit"></i> Reserva
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
    
<script>
const modalReserva={
		 instance: null,
		 procesando: false,
		    
		 init() {
		     const modalElement = document.getElementById('modalReserva');
		     this.instance = new bootstrap.Modal(modalElement);        
		},
		
		abrir(tipo, id=null){
			this.resetear();
			let titulo = 'Reserva';
			if(tipo === 'nuevo') titulo = 'Nueva Reserva';
			else if(tipo === 'editar') titulo = 'Editar Reserva';
			
			document.getElementById('modalReservaLabel').innerHTML = '<i class="fas fa-user-edit"></i> ' + titulo;
			
			this.mostrarSpinner();
	        this.instance.show();
	        
	        let fetchUrl = '<%=contextPath%>/ReservaController?op=' + tipo + '&modal=true';
	        if(id) fetchUrl += '&id=' + id;
	        
	        fetch(fetchUrl)
            .then(response => response.text())
            .then(html => {
                this.cargarContenido(html);
                this.interceptarFormulario();
            })
            .catch(error => {
                this.ocultarSpinner();
                this.mostrarMensaje('Error al cargar el formulario: ' + error.message, 'danger');
            });
		},
		
		resetear(){
			this.procesando = false;
	        this.ocultarMensaje();
	        this.habilitarBotones();
	        document.getElementById('contenidoModal').style.display = 'none';
	    },
	    
	    mostrarSpinner() {
	        document.getElementById('loadingSpinner').style.display = 'block';
	    },
	    
	    ocultarSpinner() {
	        document.getElementById('loadingSpinner').style.display = 'none';
	    },
	    
	    cargarContenido(html) {
	        document.getElementById('contenidoModal').innerHTML = html;
	        this.ocultarSpinner();
	        document.getElementById('contenidoModal').style.display = 'block';
	    },
	    
	    interceptarFormulario() {
	        const form = document.querySelector('#contenidoModal form');
	        if(!form || form.dataset.listenerAdded === 'true') return;
	        
	        form.dataset.listenerAdded = 'true';
	        form.addEventListener('submit', (e) => this.enviarFormulario(e, form));
	    },
	    
	    enviarFormulario(e, form) {
	        e.preventDefault();
	        
	        if(this.procesando) return;
	        
	        if(!form.checkValidity()) {
	            form.reportValidity();
	            return;
	        }
	        
	        this.procesando = true;
	        this.deshabilitarBotones();
	        
	        const formData = new FormData(form);
	        
	        let operacion = formData.get('op');
	        if(!operacion || !operacion.endsWith('Ajax')) {
	            formData.set('op', operacion + 'Ajax');
	        }
	        
	        const urlBase = '<%=contextPath%>/ReservaController';
	        
	        fetch(urlBase, {
	            method: 'POST',
	            headers: {
	                'X-Requested-With': 'XMLHttpRequest'
	            },
	            body: formData
	        })
	        .then(response => response.text())
	        .then(text => {
	            if(text.trim().startsWith('<')) {
	                throw new Error('El servidor devolvió HTML en lugar de JSON');
	            }
	            return JSON.parse(text);
	        })
	        .then(data => {
	            this.procesando = false;
	            
	            if(data.success) {
	                this.mostrarMensaje(data.mensaje, 'success');
	                setTimeout(() => {
	                    this.instance.hide();
	                    location.href = '<%=contextPath%>/ReservaController?op=listar';
	                }, 1500);
	            } else {
	                this.mostrarMensaje(data.mensaje, 'danger');
	                this.habilitarBotones();
	            }
	        })
	        .catch(error => {
	            this.procesando = false;
	            this.mostrarMensaje('Error: ' + error.message, 'danger');
	            this.habilitarBotones();
	        });
	    },
	    
	    deshabilitarBotones() {
	        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"], #contenidoModal button[type="submit"]');
	        const btnCerrar = document.getElementById('btnCerrarModal');
	        
	        if(btnGuardar) {
	            btnGuardar.disabled = true;
	            if(btnGuardar.tagName === 'BUTTON') {
	                btnGuardar.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';
	            } else {
	                btnGuardar.value = 'Guardando...';
	            }
	        }
	        if(btnCerrar) btnCerrar.disabled = true;
	    },
	    
	    habilitarBotones() {
	        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"], #contenidoModal button[type="submit"]');
	        const btnCerrar = document.getElementById('btnCerrarModal');
	        
	        if(btnGuardar) {
	            btnGuardar.disabled = false;
	            if(btnGuardar.tagName === 'BUTTON') {
	                btnGuardar.innerHTML = '<i class="fas fa-save"></i> Guardar';
	            } else {
	                btnGuardar.value = 'Guardar';
	            }
	        }
	        if(btnCerrar) btnCerrar.disabled = false;
	    },
	    
	    mostrarMensaje(mensaje, tipo) {
	        const mensajeDiv = document.getElementById('mensajeModal');
	        mensajeDiv.className = 'alert alert-' + tipo;
	        mensajeDiv.textContent = mensaje;
	        mensajeDiv.classList.remove('d-none');
	    },
	    
	    ocultarMensaje() {
	        document.getElementById('mensajeModal').classList.add('d-none');
	    }
};

function eliminar(id) {
    if (confirm('¿Está seguro de eliminar este Tour? Esta acción no se puede deshacer.')) {
        window.location.href = '<%=contextPath%>/ReservaController?op=eliminar&id=' + id;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    modalReserva.init();
});
</script>
</body>
</html>