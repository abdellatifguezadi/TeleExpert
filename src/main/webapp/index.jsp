<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TeleExpertise - Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 40px;
            text-align: center;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            margin: 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bienvenue sur TeleExpertise</h1>
        <p>Plateforme de télémédecine pour les professionnels de santé</p>

        <div>
            <a href="${pageContext.request.contextPath}/register" class="btn">S'inscrire</a>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">Se connecter</a>
        </div>


        <br/>
        <a href="hello-servlet">Hello Servlet</a>
    </div>
</body>
</html>