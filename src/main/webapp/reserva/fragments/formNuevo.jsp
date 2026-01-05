<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.Explorapucallpa.beans.*"%>

<%
String url = request.getContextPath() + "/";
List<Tours> listaTours = (List<Tours>) request.getAttribute("listaTours");
List<Guias> listaGuias = (List<Guias>) request.getAttribute("listaGuias");
List<Pago> listaPagos = (List<Pago>) request.getAttribute("listaPagos");
List<ClienteCargo> listaClientes = (List<ClienteCargo>) request.getAttribute("listaClientes");
%>
<form action="<%=url%>ReservaController" method="POST"
      id="formReserva" class="needs-validation" novalidate>

    <input type="hidden" name="op" value="insertarAjax">
    <input type="hidden" name="totalReserva" id="totalReserva">

    <!-- CANTIDADES -->
    <div class="row mt-3">
        <div class="col-md-6">
            <label>Cantidad Adultos</label>
            <input type="number" class="form-control"
                   name="cantidadAdulto" id="cantidadAdulto"
                   value="0" min="0" required oninput="calcularTotal()">
        </div>
        <div class="col-md-6">
            <label>Cantidad Niños</label>
            <input type="number" class="form-control"
                   name="cantidadNino" id="cantidadNino"
                   value="0" min="0" required oninput="calcularTotal()">
        </div>
    </div>

    <!-- FECHA -->
    <div class="mt-3">
        <label class="form-label">Fecha de Reserva</label>
        <input type="date" class="form-control"
               name="fechaReserva" required>
    </div>

    <!-- PRECIOS -->
    <div class="row mt-3">
        <div class="col-md-6">
            <label>Precio Adulto (S/.)</label>
            <input type="number" class="form-control"
                   name="precioAdulto" id="precioAdulto"
                   value="0" min="30" required>
        </div>
        <div class="col-md-6">
            <label>Precio Niño (S/.)</label>
            <input type="number" class="form-control"
                   name="precioNino" id="precioNino"
                   value="0" min="30" required>
        </div>
    </div>

    <!-- TOTAL -->
    <div class="alert alert-success mt-3">
        <h5>Total: SE VERA AL FINALIZAR LA RESERVA <span id="total" oninput="calcularTotal()"></span></h5>
    </div>

    <!-- TOUR -->
<input type="hidden" name="toursIdtours" id="toursIdtours">

<div class="mb-3">
    <label class="form-label">Tour seleccionado</label>
    <input type="text" id="nombreTour" class="form-control" readonly>
</div>


    <!-- GUIA -->
    <div class="mt-3">
        <label class="form-label">Guía</label>
        <select class="form-select" name="guiaIdguia" required>
            <option value="">Seleccione un Guía...</option>
            <% 
            if(listaGuias !=null && !listaGuias.isEmpty()){
            for (Guias g : listaGuias) { %>
                <option value="<%=g.getIdguia()%>">
                    <%=g.getNombreGuia()%>
                </option>
            <% } 
            } else{%>
                <option value="" disabled>No hay Guias disponibles</option>
			<%
				}
			%>
        </select>
    </div>

    <!-- PAGOS -->
    <div class="mt-3">
        <label class="form-label">Metodo de pago</label>
        <select class="form-select" name="pagoIdpago" required>
            <option value="">Seleccione un Metodo...</option>
            <% 
            if(listaPagos !=null && !listaPagos.isEmpty()){
            for (Pago p : listaPagos) { %>
                <option value="<%=p.getIdpago()%>">
                    <%=p.getMetodoPago()%>
                </option>
            <% } 
            } else{%>
                <option value="" disabled>No hay Pagos disponibles</option>
				<%
					}
					%>
        </select>
    </div>
    
        <!-- CLIENTE -->
    <div class="mt-3">
        <label class="form-label">Cliente</label>
        <select class="form-select" name="clienteIdcliente" required>
            <option value="">Seleccione un Cliente...</option>
            <% 
            if(listaClientes !=null && !listaClientes.isEmpty()){
            for (ClienteCargo c : listaClientes) { %>
                <option value="<%=c.getIdCliente()%>">
                    <%=c.getNombre()%>
                </option>
            <% } 
            } else{%>
                <option value="" disabled>No hay Clientes disponibles</option>
				<%	
					}
					%>
        </select>
    </div>

    <div class="d-grid gap-2 mt-4">
        <button class="btn btn-success" type="submit">
            <i class="fas fa-save"></i> Guardar Reserva
        </button>
    </div>
</form>

<script>
document.addEventListener('DOMContentLoaded', function () {

    const cantidadAdulto = document.getElementById('cantidadAdulto');
    const cantidadNino   = document.getElementById('cantidadNino');
    const precioAdulto   = document.getElementById('precioAdulto');
    const precioNino     = document.getElementById('precioNino');
    const totalSpan      = document.getElementById('total');
    const totalInput     = document.getElementById('totalReserva');

    function calcularTotal() {
        const adultos = parseInt(cantidadAdulto.value) || 0;
        const ninos   = parseInt(cantidadNino.value) || 0;
        const pAdulto = parseFloat(precioAdulto.value) || 0;
        const pNino   = parseFloat(precioNino.value) || 0;

        const total = (adultos * pAdulto) + (ninos * pNino);

        totalSpan.innerText = total.toFixed(2);
        totalInput.value   = total.toFixed(2);
    }

    // Eventos
    cantidadAdulto.addEventListener('input', calcularTotal);
    cantidadNino.addEventListener('input', calcularTotal);

    // Calcular al cargar
    calcularTotal();
});
</script>



<script>
(function() {
    'use strict';
    const form = document.getElementById('formReserva');
    if(form) {
        form.classList.add('was-validated');
    }
})();
</script>