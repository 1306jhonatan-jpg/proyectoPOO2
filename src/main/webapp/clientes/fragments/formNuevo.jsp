<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getContextPath() + "/";
%>

<form method="POST" id="formCliente" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="insertarAjax">

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-user"></i> Nombre <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombre" 
                   placeholder="Ej: Juan"
                   required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-user"></i> Apellido <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="apellido"
                   placeholder="Ej: Pérez García"
                   required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

	<div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-money-bill"></i> Edad <span class="text-danger">*</span>
            </label>
            <input type="number"  class="form-control" name="edad"
                   required placeholder="Ej: 18">
            <div class="invalid-feedback">Debe ser un valor numérico</div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-id-card"></i> DNI <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="dni"
                   placeholder="Ej: 12345678"
                   maxlength="8" minlength="8"
                   pattern="[0-9]{8}" required >
            <div class="invalid-feedback">Debe tener 8 dígitos</div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-phone"></i> Celular <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="celular"
                   placeholder="999999999"
                   maxlength="9">
                   <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    
        <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-envelope"></i> Correo <span class="text-danger">*</span>
            </label>
            <input type="email" class="form-control" name="correo"
                   placeholder="Ej: Explora@Pucallpa"
                   required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="d-grid gap-2">
        <button class="btn btn-success" type="submit">
            <i class="fas fa-save"></i> Guardar Cliente
        </button>
    </div>
</form>

<script>
(() => {
    'use strict';
    const form = document.getElementById('formCliente');
    form.addEventListener('submit', (event) => {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    });
})();
</script>
