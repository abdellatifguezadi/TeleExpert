<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajouter Signes Vitaux</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
<div class="max-w-xl mx-auto p-5 mt-10 bg-white rounded-lg shadow">
    <h2 class="text-2xl font-bold mb-4">Ajouter Signes Vitaux</h2>
    <form action="${pageContext.request.contextPath}/infirmier/add-signesvitaux" method="post" class="space-y-4">
        <input type="hidden" name="id" value="${param.id}" />
        <div>
            <label class="block mb-1">Tension</label>
            <input type="text" name="tension" class="w-full border rounded px-3 py-2" required />
        </div>
        <div>
            <label class="block mb-1">Fréquence cardiaque</label>
            <input type="number" name="frequenceCardiaque" class="w-full border rounded px-3 py-2" required />
        </div>
        <div>
            <label class="block mb-1">Température</label>
            <input type="number" step="0.1" name="temperature" class="w-full border rounded px-3 py-2" required />
        </div>
        <div>
            <label class="block mb-1">Fréquence respiratoire</label>
            <input type="number" name="frequenceRespiratoire" class="w-full border rounded px-3 py-2" required />
        </div>
        <div>
            <label class="block mb-1">Poids (kg)</label>
            <input type="number" step="0.1" name="poids" class="w-full border rounded px-3 py-2" required />
        </div>
        <div>
            <label class="block mb-1">Taille (m)</label>
            <input type="number" step="0.01" name="taille" class="w-full border rounded px-3 py-2" required />
        </div>
        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded">Enregistrer</button>
    </form>
</div>
</body>
</html>