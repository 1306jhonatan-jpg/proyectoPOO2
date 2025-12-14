<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Explorapucallpa.beans.Guias"%>
<% 
String url = request.getContextPath() + "/";
Guias guias = (Guias) request.getAttribute("guia");
if(guias == null) {
	guias = new Guias();
}
%>

<form action="<%=url%>GuiasController" method="POST" id="formGuia" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=guias.getIdguia()%>">

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-user"></i> Nombre del Guía <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreGuia"
                value="<%=guias.getNombreGuia()%>"
                required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-user"></i> Apellido del Guía <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="apellidoGuia"
                value="<%=guias.getApellidoGuia()%>"
                required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-id-card"></i> DNI <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="dniGuia"
                value="<%=guias.getDniGuia()%>"
                minlength="8" maxlength="8" pattern="[0-9]{8}"
                placeholder="Ej: 12345678"
                required>
            <div class="invalid-feedback">Debe contener 8 dígitos</div>
        </div>
    </div>

	    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-money-bill"></i> Pago (S/.) <span class="text-danger">*</span>
            </label>
            <input type="number" step="0.10" min="0" class="form-control" name="pago"
                value="<%=guias.getPago()%>"
                placeholder="Ej: 200.50"
                required>
            <div class="invalid-feedback">Ingrese un monto válido</div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-phone"></i> Celular
            </label>
            <input type="text" class="form-control" name="celular"
                value="<%=guias.getCelular()%>"
                placeholder="Ej: 999999999"
                minlength="9" maxlength="9" pattern="[0-9]{9}">
            <small class="form-text text-muted">Campo opcional</small>
        </div>
    </div>

	    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-building"></i> Empresa <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="empresa"
                value="<%=guias.getEmpresa()%>"
                required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="alert alert-warning" role="alert">
        <i class="fas fa-exclamation-triangle"></i> 
        Estás modificando el guía con ID: <strong><%=guias.getIdguia()%></strong>
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
    const form = document.getElementById('formGuia');
    form.addEventListener('submit', event => {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    });
})();
</script>
