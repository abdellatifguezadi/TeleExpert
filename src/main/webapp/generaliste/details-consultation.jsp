<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails Consultation</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <div class="min-h-screen bg-gradient-to-br from-blue-100 via-white to-blue-200 flex flex-col items-center py-12">
        <div class="w-full max-w-4xl px-4">
            <h1 class="text-3xl font-extrabold text-blue-700 mb-10 text-center drop-shadow">Détails des Consultations</h1>

            <c:choose>
                <c:when test="${not empty consultations}">
                    <table class="min-w-full bg-white rounded-xl shadow-xl border border-blue-200">
                        <thead>
                            <tr class="bg-blue-100 text-blue-700 text-left">
                                <th class="py-3 px-4 font-bold">ID</th>
                                <th class="py-3 px-4 font-bold">Motif</th>
                                <th class="py-3 px-4 font-bold">Status</th>
                                <th class="py-3 px-4 font-bold">Date</th>
                                <th class="py-3 px-4 font-bold">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="consultation" items="${consultations}">
                                <c:set var="modalId" value="modal_${consultation.id}" />
                                <tr class="border-b hover:bg-blue-50">
                                    <td class="py-2 px-4">#${consultation.id}</td>
                                    <td class="py-2 px-4">
                                        <c:choose>
                                            <c:when test="${not empty consultation.motif}">${consultation.motif}</c:when>
                                            <c:otherwise>Non spécifié</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-2 px-4">
                                        <c:choose>
                                            <c:when test="${not empty consultation.status}">${consultation.status}</c:when>
                                            <c:otherwise>Non défini</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-2 px-4">
                                        <c:choose>
                                            <c:when test="${not empty consultation.dateConsultation}">
                                                ${fn:substringBefore(consultation.dateConsultation, 'T')}
                                            </c:when>
                                            <c:otherwise>Non définie</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-2 px-4">
                                        <div class="flex flex-row items-center gap-2">
                                            <button onclick="openModal('${modalId}')" class="bg-blue-600 hover:bg-blue-700 text-white px-3 py-1 rounded font-bold shadow transition text-xs">Afficher</button>
                                            <form id="form-${consultation.id}" method="post" action="${pageContext.request.contextPath}/generaliste/consultation" class="inline">
                                                <select name="status" class="border rounded px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-400">
                                                    <option value="EN_ATTENTE" ${consultation.status == null || consultation.status == 'EN_ATTENTE' ? 'selected' : ''}>En attente</option>
                                                    <option value="TERMINEE" ${consultation.status == 'TERMINEE' ? 'selected' : ''}>Clôturée</option>
                                                    <option value="EN_ATTENTE_AVIS_SPECIALISTE" ${consultation.status == 'EN_ATTENTE_AVIS_SPECIALISTE' ? 'selected' : ''}>En attente d'expertise</option>
                                                    <option value="AVIS_SPECIALISTE_RECU" ${consultation.status == 'AVIS_SPECIALISTE_RECU' ? 'selected' : ''}>Avis Reçu</option>

                                                </select>
                                                <input type="hidden" name="consultationId" value="${consultation.id}" />
                                                <input type="hidden" name="patientId" value="${patientId}" />
                                                <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-3 py-1 rounded font-bold shadow transition text-xs align-middle leading-none self-center" style="margin-top:0;">Valider</button>
                                            </form>
                                            <c:if test="${consultation.status != 'EN_ATTENTE_AVIS_SPECIALISTE' && consultation.status != 'TERMINEE' && consultation.status != 'AVIS_SPECIALISTE_RECU'}">
                                                <form method="get" action="${pageContext.request.contextPath}/generaliste/SpecialisteList" class="inline">
                                                    <input type="hidden" name="consultationId" value="${consultation.id}" />
                                                    <input type="hidden" name="patientId" value="${patientId}" />
                                                    <button type="submit" class="bg-purple-600 hover:bg-purple-700 text-white px-3 py-1 rounded font-bold shadow transition text-xs align-middle leading-none self-center" style="margin-top:0;">Demander Expert</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Modales pour les détails -->
                    <c:forEach var="consultation" items="${consultations}">
                        <c:set var="modalId" value="modal_${consultation.id}" />
                        <div id="${modalId}" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
                            <div class="bg-white rounded-lg shadow-lg p-6 max-w-2xl w-full relative max-h-[80vh] overflow-y-auto mx-4">
                                <button onclick="closeModal('${modalId}')" class="absolute top-3 right-3 text-gray-500 hover:text-gray-700 text-2xl font-bold">&times;</button>
                                <div class="pr-8">
                                    <h2 class="text-xl font-bold text-gray-800 mb-4 border-b border-gray-200 pb-2">
                                        Consultation #${consultation.id}
                                    </h2>
                                    <div class="space-y-4">
                                        <!-- Diagnostic -->
                                        <div class="border border-gray-200 p-4 rounded">
                                            <h3 class="font-semibold text-gray-700 mb-2">Diagnostic :</h3>
                                            <div class="text-gray-600 break-words leading-relaxed">
                                                <c:out value="${consultation.diagnostic}" default=""/>
                                            </div>
                                        </div>
                                        <!-- Traitement -->
                                        <div class="border border-gray-200 p-4 rounded">
                                            <h3 class="font-semibold text-gray-700 mb-2">Traitement :</h3>
                                            <div class="text-gray-600 break-words leading-relaxed">
                                                <c:out value="${consultation.traitement}" default=""/>
                                            </div>
                                        </div>
                                        <!-- Observations -->
                                        <div class="border border-gray-200 p-4 rounded">
                                            <h3 class="font-semibold text-gray-700 mb-2">Observations :</h3>
                                            <div class="text-gray-600 break-words leading-relaxed">
                                                <c:out value="${consultation.observations}" default=""/>
                                            </div>
                                        </div>
                                        <c:if test="${consultation.status == 'TERMINEE'}">
                                            <div class="mt-4 text-green-700 font-bold">Consultation clôturée</div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="text-xl font-semibold text-gray-600 mb-2">Aucune consultation trouvée</p>
                    <p class="text-gray-500">Ce patient n'a pas encore de consultations enregistrées.</p>
                </c:otherwise>
            </c:choose>

            <!-- Bouton de retour -->
            <div class="mt-8 text-center">
                <a href="${pageContext.request.contextPath}/generaliste/dashboard" class="bg-gray-600 hover:bg-gray-700 text-white px-6 py-3 rounded-lg font-bold shadow transition">
                    ← Retour au tableau de bord
                </a>
            </div>
        </div>

        <script>
            function openModal(id) {
                document.getElementById(id).classList.remove('hidden');
            }
            function closeModal(id) {
                document.getElementById(id).classList.add('hidden');
            }
        </script>
    </div>
</body>
</html>
