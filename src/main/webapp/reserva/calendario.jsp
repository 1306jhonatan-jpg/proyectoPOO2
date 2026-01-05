<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendario</title>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
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
.fc {
    background: white;
    border-radius: 10px;
    padding: 10px;
}

.fc-toolbar-title {
    font-size: 1.4rem;
    font-weight: 600;
}

.fc-daygrid-day-number {
    color: #2e7d32;
    font-weight: 500;
}

.fc-event {
    border-radius: 6px;
    font-size: 0.85rem;
    padding: 2px 4px;
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

<!-- SIDEBAR -->
<jsp:include page="/componentes/navbar.jsp" />

<!-- CONTENIDO -->
<div class="content-container">
    <h2 class="text-center mb-4">
        <i class="fas fa-calendar"></i> Calendario
    </h2>

    <div id="calendar"></div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {

    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        locale: 'es',
        height: 'auto',

        events: 'ReservaController?op=listarEventosCalendario',

        eventClick: function (info) {

            const tour = info.event.title;
            const guia = info.event.extendedProps.guia;
            const personas = info.event.extendedProps.personas;

            Swal.fire({
                title: 'Detalle de la Reserva',
                icon: 'info',
                confirmButtonText: 'Aceptar',
                html:
                    '<p><b>🗺️ Tour:</b> ' + tour + '</p>' +
                    '<p><b>🧑‍💼 Guía:</b> ' + guia + '</p>' +
                    '<p><b>👥 Personas:</b> ' + personas + '</p>'
            });
        }

    });

    calendar.render();
});
</script>


</body>
</html>
