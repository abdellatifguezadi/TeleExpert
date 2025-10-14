<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Compléter le profil spécialiste</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans min-h-screen flex items-center justify-center">
    <div class="max-w-md w-full bg-white p-8 rounded-lg shadow-lg mt-10">
        <h2 class="text-2xl font-bold mb-6 text-center text-blue-700">Compléter votre profil</h2>
<%--        <% String error = (String) request.getAttribute("error"); if (error != null) { %>--%>
<%--            <div class="bg-red-100 text-red-700 px-4 py-2 rounded mb-4 text-center"><%= error %></div>--%>
<%--        <% } %>--%>
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-700 px-4 py-2 rounded mb-4 text-center">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/specialiste/complete-profile" method="post" class="space-y-4">
            <div>
                <label class="block mb-1 font-semibold">Spécialité</label>
                <select name="specialite" class="w-full border rounded px-3 py-2" required>
                    <option value="">-- Choisir --</option>
                    <option value="CARDIOLOGIE">Cardiologie</option>
                    <option value="PNEUMOLOGIE">Pneumologie</option>
                    <option value="NEUROLOGIE">Neurologie</option>
                    <option value="GASTRO_ENTEROLOGIE">Gastro-entérologie</option>
                    <option value="ENDOCRINOLOGIE">Endocrinologie</option>
                    <option value="DERMATOLOGIE">Dermatologie</option>
                    <option value="RHUMATALOGIE">Rhumatologie</option>
                    <option value="PSYCHIATRIE">Psychiatrie</option>
                    <option value="NEPHROLOGIE">Néphrologie</option>
                    <option value="ORTHOPEDIE">Orthopédie</option>

                </select>
            </div>
            <div>
                <label class="block mb-1 font-semibold">Tarif (MAD)</label>
                <input type="number" name="tarif" class="w-full border rounded px-3 py-2" min="0" step="0.01" required placeholder="Ex: 300" />
            </div>
            <div>
                <label class="block mb-1 font-semibold">Durée de consultation (minutes)</label>
                <input type="number" name="dureeConsultation" class="w-full border rounded px-3 py-2" min="1" max="180" required placeholder="Ex: 30" />
            </div>
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Enregistrer</button>
        </form>
    </div>
</body>
</html>

