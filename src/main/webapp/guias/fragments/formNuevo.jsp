<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getContextPath() + "/";
%>

<form method="POST" id="formGuia" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="insertarAjax">

    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-user"></i> Nombre <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreGuia" 
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
            <input type="text" class="form-control" name="apellidoGuia"
                   placeholder="Ej: Pérez García"
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
                   placeholder="Ej: 12345678"
                   maxlength="8" minlength="8"
                   pattern="[0-9]{8}" required >
            <div class="invalid-feedback">Debe tener 8 dígitos</div>
        </div>
    </div>

	    <div class="row">
        <div class="col-md-12 mb-3">
            <label class="form-label">
                <i class="fas fa-money-bill"></i> Pago (S/.) <span class="text-danger">*</span>
            </label>
            <input type="number" step="0.1" min="0" class="form-control" name="pago"
                   required placeholder="Ej: 200.50">
            <div class="invalid-feedback">Debe ser un valor numérico</div>
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
                <i class="fas fa-building"></i> Empresa <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="empresa"
                   placeholder="Ej: Explora Pucallpa"
                   required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>

    <div class="d-grid gap-2">
        <button class="btn btn-success" type="submit">
            <i class="fas fa-save"></i> Guardar Guía
        </button>
    </div>
</form>

<script>
(() => {
    'use strict';
    const form = document.getElementById('formGuia');
    form.addEventListener('submit', (event) => {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    });
})();
</script>
