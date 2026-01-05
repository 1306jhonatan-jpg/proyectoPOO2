<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String contextPath = request.getContextPath();
String nombreUsuario = (String) session.getAttribute("nombreCompleto");

if (nombreUsuario == null) {
	response.sendRedirect(contextPath + "/LoginController");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Explora Pucallpa - Inicio</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* Área de contenido principal */
.main-content {
	margin-left: 250px; /* ancho del navbar vertical */
	padding: 40px;
	min-height: 100vh;
	background: url("<%=contextPath%>/img/fondo_selva.png") center/cover
		fixed;
	color: white;
	text-shadow: 1px 1px 6px rgba(0, 0, 0, 0.8);
}

h1 {
	font-size: 2.6rem;
	font-weight: bold;
}

p {
	font-size: 1.2rem;
}

.welcome-card {
	background: rgba(0, 0, 0, 0.35);
	border-radius: 12px;
	padding: 25px;
	backdrop-filter: blur(2px);
}
</style>
<style>
.carousel-container {
	margin-top: 40px;
	display: flex;
	justify-content: center;
}

.carousel-img {
	width: 100%;
	height: 600px;
	object-fit: cover;
	border-radius: 12px;
	border: 2px solid rgba(255, 255, 255, 0.8);
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.7);
}

#carouselInicio {
	width: 80%;
	background: rgba(0, 0, 0, 0.45);
	padding: 12px;
	border-radius: 14px;
	backdrop-filter: blur(5px);
}
</style>
<style>
.carousel-caption {
	background: rgba(0, 0, 0, 0.55);
	padding: 15px 20px;
	border-radius: 12px;
	bottom: 20px;
	text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.8);
}

.carousel-caption h2 {
	font-size: 2.2rem;
	font-weight: bold;
	margin-bottom: 6px;
	color: white;
}

.carousel-caption p {
	font-size: 1.2rem;
	color: #f1f1f1;
}
</style>

<style>
#carouselInicio .carousel-control-prev {
    left: 30px !important;
}

#carouselInicio .carousel-control-next {
    right: 30px !important;
}
</style>

</head>

<body>

	<!-- Navbar vertical -->
	<jsp:include page="/componentes/navbar.jsp" />

	<!-- Contenido -->
	<div class="main-content">

		<div class="welcome-card">
			<h1>
				Bienvenido,
				<%=nombreUsuario%>
				👋
			</h1>
			<p>Selecciona una opción del menú lateral para comenzar tu
				experiencia con Explora Pucallpa.</p>
		</div>

		<div class="carousel-container">
		
			<div id="carouselInicio" class="carousel slide carousel-fade"
				data-bs-ride="carousel" data-bs-interval="2000">

				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselInicio"
						data-bs-slide-to="0" class="active"></button>
					<button type="button" data-bs-target="#carouselInicio"
						data-bs-slide-to="1"></button>
					<button type="button" data-bs-target="#carouselInicio"
						data-bs-slide-to="2"></button>
						<button type="button" data-bs-target="#carouselInicio"
						data-bs-slide-to="3"></button>
						<button type="button" data-bs-target="#carouselInicio"
						data-bs-slide-to="4"></button>
				</div>

				<div class="carousel-inner">

					<div class="carousel-item active">
						<img src="<%=contextPath%>/img/alto_shambillo.jpg"
							class="carousel-img">
						<div class="carousel-caption">
							<h2 class="texto-slide">Catarata Alto Shambillo</h2>
						</div>
					</div>

					<div class="carousel-item">
						<img src="<%=contextPath%>/img/yarina.jpeg"
							class="carousel-img">
						<div class="carousel-caption">
							<h2 class="texto-slide">Laguna Yarinacocha</h2>
						</div>
					</div>

					<div class="carousel-item">
						<img src="<%=contextPath%>/img/EL_VELO_DE_NOVIA_AMAZONAS_PERU.jpg"
							class="carousel-img">
						<div class="carousel-caption">
							<h2 class="texto-slide">Velo de la Novia</h2>
						</div>
					</div>
	
					<div class="carousel-item">
						<img src="<%=contextPath%>/img/regalia.jpeg"
							class="carousel-img">
						<div class="carousel-caption">
							<h2 class="texto-slide">Regalia</h2>
						</div>
					</div>
					
					<div class="carousel-item">
						<img src="<%=contextPath%>/img/shanay.jpeg"
							class="carousel-img">
						<div class="carousel-caption">
							<h2 class="texto-slide">Shanay Timpishka</h2>
						</div>
					</div>
				</div>

			

			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselInicio" data-bs-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</button>

			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselInicio" data-bs-slide="next">
				<span class="carousel-control-next-icon"></span>
			</button>
</div>
		</div>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		var myCarousel = document.querySelector('#carouselInicio');
		var carousel = new bootstrap.Carousel(myCarousel, {
			interval : 2000,
			ride : 'carousel'
		});
	</script>

</body>
</html>
