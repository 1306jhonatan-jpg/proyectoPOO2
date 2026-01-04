<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Explorapucallpa.beans.Tours"%>
<% 
String url = request.getContextPath() + "/";
Tours tour = (Tours) request.getAttribute("tour");
if(tour == null) {
    tour = new Tours();
}
%>

<form action="<%=url%>ToursController" method="POST" id="formTour" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=tour.getIdTours()%>">
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="nombreTours" class="form-label">
                <i class="fas fa-user"></i> Nombre del Tour  <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreTours" id="nombreTours" 
                value="<%=tour.getNombreTours() != null ? tour.getNombreTours() : ""%>" 
                placeholder="Ej: jperez" required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="descripcion" class="form-label">
                <i class="fas fa-id-card"></i> Descripcion <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="descripcion" id="descripcion" 
                value="<%=tour.getDescripcion() != null ? tour.getDescripcion() : ""%>" 
                placeholder="Ej: Juan Pérez García" required>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="servicios" class="form-label">
                <i class="fas fa-envelope"></i> Servicios
            </label>
            <input type="text" class="form-control" name="servicios" id="servicios" 
                value="<%=tour.getServicios() != null ? tour.getServicios() : ""%>" 
                placeholder="ejemplo@correo.com">
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
    
	<div class="row">
        <div class="col-md-12 mb-3">
            <label for="duracionTours" class="form-label">
                <i class="fas fa-envelope"></i> Duracion del Tour
            </label>
            <input type="text" class="form-control" name="duracionTours" id="duracionTours" 
                value="<%=tour.getDuracionTours() != null ? tour.getDuracionTours() : ""%>" 
                placeholder="ejemplo@correo.com">
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
        
        	<div class="row">
        <div class="col-md-12 mb-3">
            <label for="imagen" class="form-label">
                <i class="fas fa-envelope"></i> Imagen del Tour
            </label>
            <input type="text" class="form-control" name="imagen" id="imagen" 
                value="<%=tour.getImagen() != null ? tour.getImagen() : ""%>" 
                placeholder="imagen.jpg">
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
    </div>
        
        <div class="col-md-6 mb-3">
            <label for="estado" class="form-label">
                <i class="fas fa-toggle-on"></i> Estado <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="estado" id="estado" required>
                <option value="">Seleccione un estado...</option>
                <option value="ACTIVO" <%= "ACTIVO".equals(tour.getEstado()) ? "selected" : "" %>>
                    Activo
                </option>
                <option value="INACTIVO" <%= "INACTIVO".equals(tour.getEstado()) ? "selected" : "" %>>
                    Inactivo
                </option>
            </select>
            <div class="invalid-feedback">
                Por favor seleccione un estado
            </div>
        </div>
    
    <div class="alert alert-warning" role="alert">
        <i class="fas fa-exclamation-triangle"></i> 
        Modificando Tour ID: <strong><%=tour.getIdTours()%></strong><br>
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-warning">
            <i class="fas fa-save"></i> Actualizar Tour
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