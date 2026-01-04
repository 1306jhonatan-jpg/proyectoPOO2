<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getContextPath() + "/";
%>

<form action="<%=url%>ToursController" method="POST" id="formTour" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="insertarAjax">
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="nombreTours" class="form-label">
                <i class="fas fa-user"></i> Nombre del Tour <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreTours" 
                   placeholder="Ej: Juan"
                   required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>

        </div>
            
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="descripcion" class="form-label">
               <i class="fas fa-user"></i> Descripcion <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="descripcion"
                   placeholder="Ej: Pérez García"
                   required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
        </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="servicios" class="form-label">
                <i class="fas fa-id-card"></i> Servicios <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="servicios"
                   placeholder="Ej: 12345678"
					 required >
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="duracionTours" class="form-label">
               <i class="fas fa-phone"></i> Duracion del Tour <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="duracionTours"
                   placeholder="999999999"
                   required>
                   <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    
        <div class="row">
        <div class="col-md-12 mb-3">
            <label for="imagen" class="form-label">
               <i class="fas fa-phone"></i> Imagen del Tour <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="imagen"
                   placeholder="imagen.jpg"
                   required>
                   <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    
    <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle"></i> 
        <strong>Nota:</strong> El Tour se creará con estado ACTIVO por defecto.
    </div>
    
    <div class="d-grid gap-2">
        <button class="btn btn-success" type="submit">
            <i class="fas fa-save"></i> Guardar Tour
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    const form = document.getElementById('formTour');
    if(form) {
        form.classList.add('was-validated');
    }
})();
</script>