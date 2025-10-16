<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Spécialistes</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="max-w-4xl mx-auto py-8">
        <h2 class="text-2xl font-bold mb-6 text-center text-blue-700">Liste des Spécialistes</h2>
        <form method="post" action="" class="flex flex-col sm:flex-row items-center gap-4 mb-8 justify-center">
            <input type="text" name="specialite" id="specialite" placeholder="Filtrer par spécialité" class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"/>
            <input type="text" name="tarif" id="tarif" placeholder="Filtrer par tarif" class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"/>
            <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition">Filtrer</button>
        </form>
        <!-- Nouvelle grille de cartes -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <c:forEach var="specialiste" items="${specialistes}">
                <div class="bg-white rounded-xl shadow p-6 flex flex-col gap-2 border border-blue-100 relative">
                    <div class="text-blue-700 font-bold text-lg mb-2">${specialiste.nom}</div>
                    <div class="text-gray-600"><span class="font-semibold">ID :</span> ${specialiste.id}</div>
                    <div class="text-gray-600"><span class="font-semibold">Spécialité :</span> ${specialiste.specialite}</div>
                    <div class="text-gray-600"><span class="font-semibold">Tarif :</span> ${specialiste.tarif} €</div>
                    <button
                        class="mt-4 px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 transition font-semibold"
                        onclick="openCreneauModal('${specialiste.id}')"
                    >
                        Afficher les créneaux
                    </button>
                    <!-- Modal créneaux -->
                    <div id="creneau-modal-${specialiste.id}" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
                        <div class="bg-white rounded-lg shadow-lg p-6 max-w-md w-full relative">
                            <button onclick="closeCreneauModal('${specialiste.id}')" class="absolute top-3 right-3 text-gray-500 hover:text-gray-700 text-2xl font-bold">&times;</button>
                            <h3 class="text-xl font-bold text-blue-700 mb-4">Créneaux disponibles pour ${specialiste.nom}</h3>
                            <div class="flex flex-col gap-3">

                                    <c:set var="creneaux" value="${creneauxParSpecialiste[specialiste.id]}" />
                                <c:choose>
                                    <c:when test="${not empty creneaux}">
                                        <c:forEach var="creneau" items="${creneaux}">
                                            <div class="flex items-center justify-between border-b pb-2">
                                                <span>
                                                    <c:set var="heureDebut" value="${fn:substringAfter(creneau.dateHeureDebut, 'T')}" />
                                                    <c:set var="heureFin" value="${fn:substringAfter(creneau.dateHeureFin, 'T')}" />
                                                    ${heureDebut} - ${heureFin}
                                                </span>
                                                <div class="flex items-center">
                                                    <c:choose>
                                                        <c:when test="${creneau.status == 'DISPONIBLE'}">
                                                            <span class="text-green-600 font-semibold mr-2">Disponible</span>
                                                            <button class="px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 text-sm">Réserver</button>
                                                        </c:when>
                                                        <c:when test="${creneau.status == 'RESERVE'}">
                                                            <span class="text-red-600 font-semibold mr-2">Réservé</span>
                                                            <span class="px-3 py-1 bg-gray-400 text-white rounded text-sm cursor-not-allowed">Indisponible</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-gray-600 font-semibold mr-2">Archivé</span>
                                                            <span class="px-3 py-1 bg-gray-400 text-white rounded text-sm cursor-not-allowed">Indisponible</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-gray-500 text-center py-4">
                                            Aucun créneau disponible pour ce spécialiste
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <script>
        function openCreneauModal(id) {
            document.getElementById('creneau-modal-' + id).classList.remove('hidden');
        }
        function closeCreneauModal(id) {
            document.getElementById('creneau-modal-' + id).classList.add('hidden');
        }
    </script>
</body>
</html>
