<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - Spécialiste</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 font-sans">

<!-- En-tête -->
<header class="bg-blue-700 text-white py-6 text-center shadow-lg">
    <h1 class="text-3xl font-bold">Tableau de bord du Spécialiste</h1>
    <p class="text-lg">Bienvenue, <strong>
        ${utilisateur.nom} ${utilisateur.prenom}
    </strong></p>
</header>

<!-- Flash message -->
<c:if test="${not empty message}">
    <div class="max-w-5xl mx-auto mt-4">
        <div class="bg-green-100 border border-green-300 text-green-800 px-4 py-3 rounded">
            ${message}
        </div>
    </div>
</c:if>

<!-- Contenu principal -->
<main class="max-w-5xl mx-auto mt-8 space-y-8">

    <!-- Section Profil -->
    <section class="bg-white p-6 rounded-2xl shadow-md">
        <h2 class="text-2xl font-semibold mb-4 text-blue-700">Profil du Spécialiste</h2>
        <ul class="text-gray-700 space-y-2">
            <li><strong>Nom :</strong> ${utilisateur.nom}</li>
            <li><strong>Spécialité :</strong> ${utilisateur.type_medecin}</li>
            <li><strong>Tarif :</strong> ${utilisateur.tarif}</li>
            <li><strong>Durée moyenne de consultation :</strong> ${utilisateur.dureeConsultation} min</li>
        </ul>
    </section>


    <!-- Section Demandes d'expertise -->
    <section class="bg-white p-6 rounded-2xl shadow-md">
        <h2 class="text-2xl font-semibold mb-4 text-blue-700">Demandes d'Expertise</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-300 rounded-lg">
                <thead class="bg-blue-600 text-white">
                <tr>
                    <th class="py-3 px-4 text-left">Patient</th>
                    <th class="py-3 px-4 text-left">Priorite</th>
                    <th class="py-3 px-4 text-left">Question</th>
                    <th class="py-3 px-4 text-left">Statut</th>
                    <th class="py-3 px-4 text-center">Action</th>
                </tr>
                </thead>
                <tbody class="text-gray-700">
                <c:choose>
                    <c:when test="${not empty demandes}">
                        <c:forEach var="demande" items="${demandes}">
                            <tr class="border-b hover:bg-gray-50">
                                <td class="py-2 px-4">
                                    <c:choose>
                                        <c:when test="${not empty demande.consultation and not empty demande.consultation.patient}">
                                            ${demande.consultation.patient.nom} ${demande.consultation.patient.prenom}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-2 px-4 text-yellow-600 font-semibold">${demande.priorite}</td>
                                <td class="py-2 px-4">${demande.question}</td>
                                <td class="py-2 px-4">${demande.status}</td>
                                <td class="py-2 px-4 text-center">
                                    <div class="flex flex-row items-center justify-center gap-2">
                                        <c:choose>
                                            <c:when test="${demande.status == 'TERMINEE'}">
                                                <button disabled class="bg-gray-400 text-white px-2 py-1 rounded text-xs cursor-not-allowed">Repondre</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button onclick="showModal('${demande.consultation.patient.nom} ${demande.consultation.patient.prenom}', ${demande.id})" class="bg-blue-600 text-white px-2 py-1 rounded text-xs hover:bg-blue-700">Repondre</button>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:if test="${not empty demande.consultation and not empty demande.consultation.patient}">
                                            <button onclick="openConsultationModal(this)"
                                                    class="bg-green-600 text-white px-2 py-1 rounded text-xs hover:bg-green-700"
                                                    data-date="${fn:escapeXml(demande.consultation.dateConsultation)}"
                                                    data-motif="${fn:escapeXml(demande.consultation.motif)}"
                                                    data-observations="${fn:escapeXml(demande.consultation.observations)}"
                                                    data-patient-nom="${fn:escapeXml(demande.consultation.patient.nom)}"
                                                    data-patient-prenom="${fn:escapeXml(demande.consultation.patient.prenom)}"
                                                    data-patient-telephone="${fn:escapeXml(demande.consultation.patient.telephone)}"
                                                    data-antecedents="${fn:escapeXml(demande.consultation.patient.dossierMedical.antecedents)}"
                                                    data-allergies="${fn:escapeXml(demande.consultation.patient.dossierMedical.allergies)}"
                                                    data-traitement="${fn:escapeXml(demande.consultation.patient.dossierMedical.traitementEnCours)}"
                                            >Voir Consultation</button>

                                            <c:if test="${not empty demande.consultation.patient.signesVitaux}">
                                                <button onclick="openSignesModal(this)"
                                                        class="bg-purple-600 text-white px-2 py-1 rounded text-xs hover:bg-purple-700"
                                                        data-fc="${fn:escapeXml(demande.consultation.patient.signesVitaux.frequenceCardiaque)}"
                                                        data-tension="${fn:escapeXml(demande.consultation.patient.signesVitaux.tension)}"
                                                        data-temp="${fn:escapeXml(demande.consultation.patient.signesVitaux.temperature)}"
                                                        data-poids="${fn:escapeXml(demande.consultation.patient.signesVitaux.poids)}"
                                                        data-frequence-respiratoire="${fn:escapeXml(demande.consultation.patient.signesVitaux.frequenceRespiratoire)}"
                                                        data-taille="${fn:escapeXml(demande.consultation.patient.signesVitaux.taille)}"
                                                >Voir Signes Vitaux</button>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="5" class="py-4 px-6">Aucune demande trouvée.</td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </section>

</main>

<!-- Modal Reponse -->
<div id="modal" class="hidden fixed inset-0 bg-gray-800 bg-opacity-60 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-full max-w-lg">
        <h2 class="text-2xl font-semibold mb-4 text-blue-700">Repondre a une Expertise</h2>
        <form class="space-y-4" method="post" action="${pageContext.request.contextPath}/specialiste/dashboard">
            <input type="hidden" id="modal-demande-id" name="demandeId" />
            <div>
                <label for="modal-patient" class="block text-gray-700">Patient</label>
                <input id="modal-patient" type="text" class="w-full border rounded-lg px-3 py-2 mt-1" readonly>
            </div>
            <div>
                <label for="modal-avis" class="block text-gray-700">Avis medical</label>
                <textarea id="modal-avis" name="avisMedecin" class="w-full border rounded-lg px-3 py-2 mt-1" rows="4" placeholder="Saisir l'avis du specialiste..."></textarea>
            </div>
            <div>
                <label for="modal-rec" class="block text-gray-700">Recommandations</label>
                <textarea id="modal-rec" name="recommandations" class="w-full border rounded-lg px-3 py-2 mt-1" rows="3" placeholder="Saisir les recommandations..."></textarea>
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" onclick="hideModal()" class="bg-gray-400 text-white px-6 py-2 rounded-lg hover:bg-gray-500 transition">Annuler</button>
                <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition">Marquer comme Terminee</button>
            </div>
        </form>
    </div>
</div>

<!-- Consultation Modal -->
<div id="modal-consultation" class="hidden fixed inset-0 bg-gray-800 bg-opacity-60 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-full max-w-2xl">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-semibold text-blue-700">Détails de la Consultation</h2>
            <button onclick="closeConsultationModal()" class="text-gray-600 hover:text-gray-900">Fermer</button>
        </div>
        <div class="space-y-3 text-gray-700">
            <p><strong>Date:</strong> <span id="consultation-date">-</span></p>
            <p><strong>Motif:</strong> <span id="consultation-motif">-</span></p>
            <p><strong>Observations:</strong> <span id="consultation-observations">-</span></p>
            <p><strong>Traitement en cours:</strong> <span id="consultation-traitement">-</span></p>
            <h3 class="font-semibold mt-3">Patient & Dossier Médical</h3>
            <p><strong>Nom:</strong> <span id="consultation-patient-nom">-</span></p>
            <p><strong>Prénom:</strong> <span id="consultation-patient-prenom">-</span></p>
            <p><strong>Téléphone:</strong> <span id="consultation-patient-telephone">-</span></p>
            <p><strong>Antécédents:</strong> <span id="consultation-antecedents">-</span></p>
            <p><strong>Allergies:</strong> <span id="consultation-allergies">-</span></p>
        </div>
    </div>
</div>

<!-- Signes Vitaux Modal -->
<div id="modal-signes" class="hidden fixed inset-0 bg-gray-800 bg-opacity-60 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-full max-w-lg">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-semibold text-blue-700">Signes Vitaux</h2>
            <button onclick="closeSignesModal()" class="text-gray-600 hover:text-gray-900">Fermer</button>
        </div>
        <div class="space-y-2 text-gray-700">
            <p><strong>Fréquence cardiaque:</strong> <span id="signes-fc">-</span></p>
            <p><strong>Tension:</strong> <span id="signes-tension">-</span></p>
            <p><strong>Température:</strong> <span id="signes-temp">-</span></p>
            <p><strong>Poids:</strong> <span id="signes-poids">-</span></p>
            <p><strong>Fréquence respiratoire:</strong> <span id="signes-frequence-respiratoire">-</span></p>
            <p><strong>Taille:</strong> <span id="signes-taille">-</span></p>
        </div>
    </div>
</div>

<footer class="text-center py-6 text-gray-500 mt-10">
    <p>&copy; 2025 Tele-Expertise Medicale - Tous droits reserves</p>
</footer>

<script>
    function showModal(patientName, demandeId) {
        document.getElementById('modal').classList.remove('hidden');
        document.getElementById('modal-patient').value = patientName;
        document.getElementById('modal-demande-id').value = demandeId;
    }

    function hideModal() {
        document.getElementById('modal').classList.add('hidden');
    }

    function openConsultationModal(btn) {
        document.getElementById('consultation-date').textContent = btn.getAttribute('data-date') || '-';
        document.getElementById('consultation-motif').textContent = btn.getAttribute('data-motif') || '-';
        document.getElementById('consultation-observations').textContent = btn.getAttribute('data-observations') || '-';
        document.getElementById('consultation-patient-nom').textContent = btn.getAttribute('data-patient-nom') || '-';
        document.getElementById('consultation-patient-prenom').textContent = btn.getAttribute('data-patient-prenom') || '-';
        document.getElementById('consultation-patient-telephone').textContent = btn.getAttribute('data-patient-telephone') || '-';
        document.getElementById('consultation-antecedents').textContent = btn.getAttribute('data-antecedents') || '-';
        document.getElementById('consultation-allergies').textContent = btn.getAttribute('data-allergies') || '-';
        document.getElementById('consultation-traitement').textContent = btn.getAttribute('data-traitement') || '-';
        document.getElementById('modal-consultation').classList.remove('hidden');
    }
    function closeConsultationModal() {
        document.getElementById('modal-consultation').classList.add('hidden');
    }

    function openSignesModal(btn) {
        document.getElementById('signes-fc').textContent = btn.getAttribute('data-fc') || '-';
        document.getElementById('signes-tension').textContent = btn.getAttribute('data-tension') || '-';
        document.getElementById('signes-temp').textContent = btn.getAttribute('data-temp') || '-';
        document.getElementById('signes-poids').textContent = btn.getAttribute('data-poids') || '-';
        document.getElementById('signes-frequence-respiratoire').textContent = btn.getAttribute('data-frequence-respiratoire') || '-';
        document.getElementById('signes-taille').textContent = btn.getAttribute('data-taille') || '-';
        document.getElementById('modal-signes').classList.remove('hidden');
    }
    function closeSignesModal() {
        document.getElementById('modal-signes').classList.add('hidden');
    }

</script>

</body>
</html>
