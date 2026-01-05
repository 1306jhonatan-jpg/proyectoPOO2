<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/app.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<title><jsp:doBody /></title>
</head>

<body>
    <jsp:include page="/componentes/navbar.jsp" />

    <div class="content-container">
        <jsp:doBody />
    </div>
</body>
</html>