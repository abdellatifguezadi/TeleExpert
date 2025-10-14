<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajouter/Modifier Dossier Médical</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="max-w-xl mx-auto p-5 mt-10 bg-white rounded-lg shadow">
        <h2 class="text-2xl font-bold mb-4">Ajouter/Modifier Dossier Médical</h2>
        <form action="${pageContext.request.contextPath}/infirmier/add-dossiermedical" method="post" class="space-y-4">
            <input type="hidden" name="id" value="${param.id}" />
            <div>
                <label class="block mb-1">Antécédents</label>
                <textarea name="antecedents" class="w-full border rounded px-3 py-2"></textarea>
            </div>
            <div>
                <label class="block mb-1">Allergies</label>
                <textarea name="allergies" class="w-full border rounded px-3 py-2"></textarea>
            </div>
            <div>
                <label class="block mb-1">Traitement en cours</label>
                <textarea name="traitementEnCours" class="w-full border rounded px-3 py-2"></textarea>
            </div>
            <button type="submit" class="bg-yellow-600 text-white px-4 py-2 rounded">Enregistrer</button>
        </form>
    </div>
</body>
</html>
