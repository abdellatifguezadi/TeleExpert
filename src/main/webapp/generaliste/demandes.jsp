<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/jsp/includes/header.jspf" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demandes d'expertise - Généraliste</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<div class="max-w-6xl mx-auto mt-8">
    <div class="bg-white p-6 rounded-2xl shadow-md">
        <h1 class="text-2xl font-bold text-blue-700 mb-4">Demandes d'expertise reçues</h1>

        <c:if test="${empty demandes}">
            <div class="py-6 text-gray-600">Aucune demande trouvée.</div>
        </c:if>

        <c:if test="${not empty demandes}">
            <div class="overflow-x-auto">
                <table class="min-w-full border border-gray-200 rounded-lg">
                    <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="py-3 px-4 text-left">ID</th>
                        <th class="py-3 px-4 text-left">Patient</th>
                        <th class="py-3 px-4 text-left">Spécialiste</th>
                        <th class="py-3 px-4 text-left">Question</th>
                        <th class="py-3 px-4 text-left">Avis du spécialiste</th>
                        <th class="py-3 px-4 text-left">Recommandations</th>
                        <th class="py-3 px-4 text-left">Consultation</th>
                        <th class="py-3 px-4 text-center">Action</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white text-gray-700">
                    <c:forEach var="demande" items="${demandes}">
                        <tr class="border-b hover:bg-gray-50">
                            <td class="py-3 px-4">${demande.id}</td>
                            <td class="py-3 px-4">
                                <c:choose>
                                    <c:when test="${not empty demande.consultation and not empty demande.consultation.patient}">
                                        ${demande.consultation.patient.nom} ${demande.consultation.patient.prenom}
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="py-3 px-4">
                                <c:choose>
                                    <c:when test="${not empty demande.medecinSpecialiste}">
                                        ${demande.medecinSpecialiste.nom} ${demande.medecinSpecialiste.prenom}
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="py-3 px-4">${demande.question}</td>
                            <td class="py-3 px-4 text-sm">${fn:escapeXml(demande.avisMedecin)}</td>
                            <td class="py-3 px-4 text-sm">${fn:escapeXml(demande.recommandations)}</td>
                            <td class="py-3 px-4 text-sm">
                                <c:choose>
                                    <c:when test="${not empty demande.consultation}">
                                        #${demande.consultation.id} - ${demande.consultation.motif}
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="py-3 px-4 text-center">
                                <c:choose>
                                    <c:when test="${demande.consultation.status == 'TERMINEE'}">
                                        <button disabled class="bg-gray-400 text-white px-3 py-1 rounded text-xs">Clôturée</button>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/generaliste/consultation" method="post" style="display:inline;">
                                            <input type="hidden" name="consultationId" value="${demande.consultation.id}" />
                                            <input type="hidden" name="patientId" value="${demande.consultation.patient.id}">
                                            <input type="hidden" name="status" value="TERMINEE">
                                            <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-3 py-1 rounded text-xs">Clôturer</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div class="mt-6">
            <a href="${pageContext.request.contextPath}/generaliste/dashboard" class="text-blue-600 hover:underline">Retour au tableau</a>
        </div>
    </div>
</div>

</body>
</html>
