<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Explorapucallpa.beans.Guias" %>

<%
String url = request.getContextPath();
List<Guias> lista = (List<Guias>) request.getAttribute("listaGuias");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Guías</title>

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
    
    <h2 class="mb-4">
        <i class="fas fa-user-shield"></i> Listado de Guias
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
    <button class="btn btn-success mb-3" onclick="modalGuia.abrir('nuevo')">
        <i class="fas fa-plus"></i> Nuevo Guia
    </button>

	<div class="table-responsive">
    <table class="table table-bordered table-striped table-hover">
        <thead class="table-success">
            <tr>
                <th><i class="fas fa-hashtag"></i> ID</th>
                <th><i class="fas fa-user"></i> Nombre Completo</th>
                <th><i class="fas fa-id-card"></i> DNI</th>
                <th><i class="fas fa-money-bill"></i> Pago</th>
                <th><i class="fas fa-phone"></i> Celular</th>
                <th><i class="fas fa-building"></i> Empresa</th>
                <th class="text-center"><i class="fas fa-cog"></i> Operaciones</th>
            </tr>
        </thead>

        <tbody>
        <% 
        List<Guias> listaGuias = (List<Guias>) request.getAttribute("listaGuias");
        if(listaGuias != null && !listaGuias.isEmpty()) { 
            for(Guias g : listaGuias){ %>
            <tr>
                <td><code><%=g.getIdguia()%></code></td>
                <td><strong><%=g.getNombreGuia()%> <%=g.getApellidoGuia()%></strong></td>
                <td><%=g.getDniGuia()%></td>
                <td>S/. <%=g.getPago()%></td>
                <td><%=g.getCelular()%></td>             
                <td><%=g.getEmpresa() %></td>
                <td class="text-center">
                	<div class="btn-group" role="group">
                    <button class="btn btn-warning btn-sm"
                            onclick="modalGuia.abrir('editar',<%=g.getIdguia()%>)"
                            title="Modificar guia">
                        <i class="fa fa-edit"></i>
                    </button>
                    <button class="btn btn-danger btn-sm"
                            onclick="eliminar(<%=g.getIdguia()%>)"
                            title="Eliminar guia">
                        <i class="fa fa-trash"></i>
                    </button>
                    </div>
                </td>
            </tr>
        <% } 
           } else{%>
           <tr>
                    <td colspan="7" class="text-center text-muted">
                        <i class="fas fa-inbox"></i> No hay guias registrados
                    </td>
                </tr>
                <%
                }
                %>
        </tbody>
    </table>
</div>
</div>

<!-- Modal -->
<div class="modal fade" id="modalGuia" tabindex="-1"
	aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	 <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
            <h5 class="modal-title" id="modalGuiaLabel">
                    <i class="fas fa-user-edit"></i> Guia
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
const modalGuia={
		 instance: null,
		 procesando: false,
		    
		 init() {
		     const modalElement = document.getElementById('modalGuia');
		     this.instance = new bootstrap.Modal(modalElement);        
		},
		
		abrir(tipo, id=null){
			this.resetear();
			let titulo = 'Guia';
			if(tipo === 'nuevo') titulo = 'Nuevo Guia';
			else if(tipo === 'editar') titulo = 'Editar Guia';
			
			document.getElementById('modalGuiaLabel').innerHTML = '<i class="fas fa-user-edit"></i> ' + titulo;
			
			this.mostrarSpinner();
	        this.instance.show();
	        
	        let fetchUrl = '<%=url%>/GuiasController?op=' + tipo + '&modal=true';
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
	        
	        const urlBase = '<%=url%>/GuiasController';
	        
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
	                    location.href = '<%=url%>/GuiasController?op=listar';
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
    if (confirm('¿Está seguro de eliminar este guia? Esta acción no se puede deshacer.')) {
        window.location.href = '<%=url%>/GuiasController?op=eliminar&id=' + id;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    modalGuia.init();
});
</script>

</body>
</html>
