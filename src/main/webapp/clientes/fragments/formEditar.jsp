<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Explorapucallpa.beans.ClienteCargo"%>
<% 
String url = request.getContextPath() + "/";
ClienteCargo clientes = (ClienteCargo) request.getAttribute("cliente");
if(clientes == null) {
	clientes = new ClienteCargo();
}
%>

<form action="<%=url%>ClientesCargoController" method="POST" id="formCliente" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=clientes.getIdCliente()%>">

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-user"></i> Nombre <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombre"
                value="<%=clientes.getNombre()%>"
                required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-user"></i> Apellidos <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="apellido"
                value="<%=clientes.getApellido()%>"
                required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-money-bill"></i> Edad <span class="text-danger">*</span>
            </label>
            <input type="number" class="form-control" name="edad"
                value="<%=clientes.getEdad()%>"
                placeholder="Ej: 18"
                required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-id-card"></i> DNI <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="dni"
                value="<%=clientes.getDni()%>"
                minlength="8" maxlength="8" pattern="[0-9]{8}"
                placeholder="Ej: 12345678"
                required>
            <div class="invalid-feedback">Debe contener 8 dígitos</div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-phone"></i> Celular
            </label>
            <input type="text" class="form-control" name="celular"
                value="<%=clientes.getCelular()%>"
                placeholder="Ej: 999999999"
                minlength="9" maxlength="9" pattern="[0-9]{9}">
            <small class="form-text text-muted">Campo opcional</small>
        </div>
    </div>

	    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-envelope"></i> Correo <span class="text-danger">*</span>
            </label>
            <input type="email" class="form-control" name="correo"
                value="<%=clientes.getCorreo()%>"
                required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="alert alert-warning" role="alert">
        <i class="fas fa-exclamation-triangle"></i> 
        Estás modificando el Cliente con ID: <strong><%=clientes.getIdCliente()%></strong>
    </div>

    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-warning">
            <i class="fas fa-save"></i> Guardar Cambios
        </button>
    </div>
</form>

<script>
(() => {
    'use strict';
    const form = document.getElementById('formCliente');
    form.addEventListener('submit', event => {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    });
})();
</script>
