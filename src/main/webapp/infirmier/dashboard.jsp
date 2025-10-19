<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Infirmier Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="max-w-7xl mx-auto p-5">
        <!-- Header -->
        <div class="bg-blue-800 text-white p-6 rounded-lg mb-8 text-center">
            <h1 class="text-3xl font-bold mb-2">Tableau de bord - Infirmier</h1>
            <p class="text-gray-200">Gestion des patients et soins infirmiers</p>
        </div>
        <!-- Actions Bar -->
        <div class="bg-white p-4 rounded-lg shadow-md mb-6 flex justify-end">
            <div class="flex gap-3">
                <a href="${pageContext.request.contextPath}/infirmier/add-patient" class="bg-green-600 hover:bg-green-700 text-white px-5 py-2 rounded-lg transition-colors duration-200 flex items-center gap-2">
                     Ajouter un Patient
                </a>
            </div>
        </div>
        <!-- Patients Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gray-700 text-white">
                        <tr>
                            <th class="px-4 py-3 text-left font-semibold">ID</th>
                            <th class="px-4 py-3 text-left font-semibold">Nom complet</th>
                            <th class="px-4 py-3 text-left font-semibold">Date de naissance</th>
                            <th class="px-4 py-3 text-left font-semibold">N° Sécurité Sociale</th>
                            <th class="px-4 py-3 text-left font-semibold">Téléphone</th>
                            <th class="px-4 py-3 text-left font-semibold">Mutuelle</th>
                            <th class="px-4 py-3 text-left font-semibold">Statut</th>
                            <th class="px-4 py-3 text-left font-semibold">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:choose>
                            <c:when test="${not empty patients}">
                                <c:forEach var="patient" items="${patients}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-4 py-3 text-sm text-gray-900">#${patient.id}</td>
                                        <td class="px-4 py-3 text-sm font-medium text-gray-900">${patient.nom} ${patient.prenom}</td>
                                        <td class="px-4 py-3 text-sm text-gray-900">
                                            <c:choose>
                                                <c:when test="${not empty patient.dateNaissance}">
                                                    ${patient.dateNaissance}
                                                </c:when>
                                                <c:otherwise>

                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-3 text-sm text-gray-900">${patient.numSecu}</td>
                                        <td class="px-4 py-3 text-sm text-gray-900">${patient.telephone}</td>
                                        <td class="px-4 py-3 text-sm text-gray-900">
                                            <c:choose>
                                                <c:when test="${not empty patient.mutuelle}">
                                                    ${patient.mutuelle}
                                                </c:when>
                                                <c:otherwise>
                                                    Non renseigné
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-3 text-sm">
                                            <c:choose>
                                                <c:when test="${patient.fileAttente}">
                                                    <span class="inline-flex px-3 py-1 text-xs font-semibold rounded-full bg-yellow-500 text-white">
                                                        En attente
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex px-3 py-1 text-xs font-semibold rounded-full bg-green-500 text-white">
                                                        Disponible
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-4 py-3 text-sm">
                                            <div class="flex gap-2">
                                                <c:choose>
                                                    <c:when test="${not empty patient.signesVitaux}">
                                                        <span class="inline-flex items-center px-3 py-1 text-xs font-medium rounded text-gray-700 bg-gray-200">
                                                            Signes vitaux enregistrés
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="add-signesvitaux.jsp?id=${patient.id}" class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-xs transition-colors">
                                                             ajoute signes vitaux
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>

                                                <c:choose>
                                                    <c:when test="${not empty patient.dossierMedical}">
                                                        <span class="inline-flex items-center px-3 py-1 text-xs font-medium rounded text-gray-700 bg-gray-200">
                                                            Dossier médical présent
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="add-dossiermedical.jsp?id=${patient.id}" class="bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded text-xs transition-colors">
                                                             ajoute dossier medical
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="px-4 py-12 text-center text-gray-500">
                                        <div>
                                            <h3 class="text-lg font-medium mb-2">Aucun patient enregistré</h3>
                                            <p class="text-sm">Commencez par ajouter votre premier patient en cliquant sur le bouton "Ajouter un Patient"</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
