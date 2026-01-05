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
        <i class="fa-solid fa-calendar"></i> Calendario
    </h2>

    <div id="calendar"></div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var calendar = new FullCalendar.Calendar(
        document.getElementById('calendar'), {
        initialView: 'dayGridMonth',
        locale: 'es',
        height: 'auto',
        events: '<%=request.getContextPath()%>/ReservaController?op=listarEventosCalendario',
        eventClick: function(info) {
            alert('Personas: ' + info.event.extendedProps.personas);
        }
    });
    calendar.render();
});
</script>

</body>
</html>
