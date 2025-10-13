<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.teleexpertise.model.Patient" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>File d'attente des patients</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
<div class="max-w-5xl mx-auto px-4 py-8">
    <div class="bg-gradient-to-r from-blue-700 to-blue-400 rounded-lg p-6 mb-8 flex items-center justify-between shadow-lg">
        <div class="flex items-center gap-4">
            <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path d="M15.232 15.232a6 6 0 1 1 1.414-1.414l5.387 5.387a1 1 0 0 1-1.414 1.414l-5.387-5.387z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <h2 class="text-3xl font-bold text-white">File d'attente des patients</h2>
        </div>
    </div>
    <div class="overflow-x-auto bg-white shadow-xl rounded-2xl border border-blue-100">
        <table class="w-full divide-y divide-blue-100 rounded-2xl overflow-hidden">
            <thead class="bg-blue-600">
            <tr>
                <th class="py-4 px-4 text-left text-sm font-bold text-white uppercase tracking-wider rounded-tl-2xl">ID</th>
                <th class="py-4 px-4 text-left text-sm font-bold text-white uppercase tracking-wider">Nom</th>
                <th class="py-4 px-4 text-center text-sm font-bold text-white uppercase tracking-wider">Consultation</th>
                <th class="py-4 px-4 text-center text-sm font-bold text-white uppercase tracking-wider">Signes Vitaux</th>
                <th class="py-4 px-4 text-center text-sm font-bold text-white uppercase tracking-wider">Télé-expertise</th>
                <th class="py-4 px-4 text-center text-sm font-bold text-white uppercase tracking-wider">Détails</th>
                <th class="py-4 px-4 text-center text-sm font-bold text-white uppercase tracking-wider">Dossier</th>
            </tr>
            </thead>
            <tbody class="divide-y divide-blue-50">

                <%
                    List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    if (patients != null && !patients.isEmpty()) {
                        for (Patient patient : patients) {
                %>
            <tr class="hover:bg-blue-50 transition">
                <td name="patientId" class="py-4 px-4 text-gray-700 font-mono font-bold"><%=patient.getId()%></td>
                <td class="py-4 px-4 font-semibold text-gray-900 flex items-center gap-3">
                    <%=patient.getNom()%> <%= patient.getPrenom()%>
                </td>
                <td class="py-4 px-4 text-center">
                    <button  onclick="openConsultationModal(<%=patient.getId()%>)" class="bg-green-500 hover:bg-green-600 text-white px-3 py-2 rounded-lg text-xs font-bold shadow flex items-center gap-1 mx-auto">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M8 12h8m-4-4v8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>Consultation
                    </button>
                </td>
                <td class="py-4 px-4 text-center">
                    <button onclick="openModalSignes(<%=patient.getId()%>)" class="bg-gray-400 hover:bg-gray-500 text-white px-3 py-2 rounded-lg text-xs font-bold shadow flex items-center gap-1 mx-auto">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M3 7v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>Signes Vitaux
                    </button>
                    <input type="hidden" id="signes-<%=patient.getId()%>-frequenceCardiaque" value="<%=patient.getSignesVitaux() != null ? patient.getSignesVitaux().getFrequenceCardiaque(): "Non renseigné"%>" />
                    <input type="hidden" id="signes-<%=patient.getId()%>-frequenceRespiratoire" value="<%=patient.getSignesVitaux() != null ? patient.getSignesVitaux().getFrequenceRespiratoire() : "Non renseigné"%>" />
                    <input type="hidden" id="signes-<%=patient.getId()%>-tension" value="<%=patient.getSignesVitaux() != null ? patient.getSignesVitaux().getTension() : "Non renseigné"%>" />
                    <input type="hidden" id="signes-<%=patient.getId()%>-temperature" value="<%=patient.getSignesVitaux() != null ? patient.getSignesVitaux().getTemperature() : "Non renseigné"%>" />
                    <input type="hidden" id="signes-<%=patient.getId()%>-taille" value="<%=patient.getSignesVitaux() != null ? patient.getSignesVitaux().getTaille() : "Non renseigné"%>" />
                    <input type="hidden" id="signes-<%=patient.getId()%>-poids" value="<%=patient.getSignesVitaux() != null ? patient.getSignesVitaux().getPoids() : "Non renseigné"%>" />

                </td>
                <td class="py-4 px-4 text-center">
                    <button  onclick="openModal('teleModal')" class="bg-red-500 hover:bg-red-600 text-white px-3 py-2 rounded-lg text-xs font-bold shadow flex items-center gap-1 mx-auto">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 10l4.553-2.276A2 2 0 0 1 22 9.618v4.764a2 2 0 0 1-2.447 1.894L15 14M4 6v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2H6a2 2 0 0 0-2 2z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>Télé
                    </button>
                </td>
                <td class="py-4 px-4 text-center">
                    <form action="<%= request.getContextPath() %>/generaliste/consultation" method="get" style="display:inline;">
                        <input type="hidden" name="patientId" value="<%=patient.getId()%>" />
                        <button type="submit" class="bg-gray-800 hover:bg-gray-900 text-white px-3 py-2 rounded-lg text-xs font-bold shadow flex items-center gap-1 mx-auto">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 12H9m12 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>Détails
                        </button>
                    </form>
                </td>
                <td class="py-4 px-4 text-center">
                    <button onclick="openModalDossier(<%=patient.getId()%>)" class="bg-gray-400 hover:bg-gray-500 text-white px-3 py-2 rounded-lg text-xs font-bold shadow flex items-center gap-1 mx-auto">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M3 7v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>Dossier
                    </button>
                    <input type="hidden" id="dossier-<%=patient.getId()%>-antecedents" value="<%=patient.getDossierMedical() != null ? patient.getDossierMedical().getAntecedents() : "Non renseigné"%>" />
                    <input type="hidden" id="dossier-<%=patient.getId()%>-allergies" value="<%=patient.getDossierMedical() != null ? patient.getDossierMedical().getAllergies() : "Non renseigné"%>" />
                    <input type="hidden" id="dossier-<%=patient.getId()%>-traitement" value="<%=patient.getDossierMedical() != null ? patient.getDossierMedical().getTraitementEnCours() : "Non renseigné"%>" />
                </td>
            </tr>
            <% } %>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Consultation Modal -->
<div id="consultationModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-40 flex items-center justify-center">
  <div class="bg-white p-6 rounded shadow-lg w-full max-w-md">
    <h3 class="text-lg font-bold mb-4">Nouvelle Consultation</h3>
      <form action="<%= request.getContextPath() %>/generaliste/dashboard" method="post" class="space-y-6">
        <input type="hidden" name="patientId" id="consultationPatientId" />
        <label class="block text-sm font-medium text-gray-700 mb-3">
            Motif
        </label>
      <input type="text" name="motif" class="w-full mb-2 border rounded px-2 py-1" placeholder="Motif" />
        <label class="block text-sm font-medium text-gray-700 mb-3">
            diagnostic
        </label>
        <input type="text" name="diagnostic" class="w-full mb-2 border rounded px-2 py-1" placeholder="diagnostic" />
        <label class="block text-sm font-medium text-gray-700 mb-3">
            traitement
        </label>
        <input type="text" name="traitement" class="w-full mb-2 border rounded px-2 py-1" placeholder="traitement" />
        <label class="block text-sm font-medium text-gray-700 mb-3">
            Observations
        </label>
      <textarea name="observations" class="w-full mb-2 border rounded px-2 py-1" placeholder="Observations"></textarea>
      <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded">Valider</button>
      <button type="button" onclick="closeModal('consultationModal')" class="ml-2 px-4 py-2 rounded border">Annuler</button>
    </form>
  </div>
</div>

<!-- Dossier Médical Modal -->
<div id="dossierModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
    <div class="bg-white rounded-lg shadow-lg p-6 max-w-2xl w-full relative max-h-[80vh] overflow-y-auto mx-4">
        <button onclick="closeModal('dossierModal')" class="absolute top-3 right-3 text-gray-500 hover:text-gray-700 text-2xl font-bold">&times;</button>
        <input type="hidden" name="patientId" id="dossierId" />
        <div class="pr-8">
            <h2 class="text-xl font-bold text-gray-800 mb-4 border-b border-gray-200 pb-2">
                Dossier Médical
            </h2>
            <div class="space-y-4">
                <!-- Antécédents -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Antécédents :</h3>
                    <div id="dossier-antecedents" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
                <!-- Allergies -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Allergies :</h3>
                    <div id="dossier-allergies" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
                <!-- Traitement en cours -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Traitement en cours :</h3>
                    <div id="dossier-traitement" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Signes Vitaux Modal -->
<div id="signesModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
    <div class="bg-white rounded-lg shadow-lg p-6 max-w-2xl w-full relative max-h-[80vh] overflow-y-auto mx-4">
        <button onclick="closeModal('signesModal')" class="absolute top-3 right-3 text-gray-500 hover:text-gray-700 text-2xl font-bold">&times;</button>
        <input type="hidden" name="patientId" id="dossierId" />
        <div class="pr-8">
            <h2 class="text-xl font-bold text-gray-800 mb-4 border-b border-gray-200 pb-2">
                Signes Vitaux
            </h2>
            <div class="space-y-4">
                <!-- Frequence Cardiaque -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Frequence Cardiaque :</h3>
                    <div id="signes-frequenceCardiaque" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
                <!-- Frequence Respiratoire  -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Frequence Respiratoire :</h3>
                    <div id="signes-frequenceRespiratoire" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
                <!-- tension -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Tension :</h3>
                    <div id="signes-tension" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
                <!-- Temperature -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Temperature :</h3>
                    <div id="signes-temperature" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
                <!-- taille-->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Taille :</h3>
                    <div id="signes-taille" class="text-gray-600 break-words leading-relaxed"></div>
                </div>
                <!-- poids -->
                <div class="border border-gray-200 p-4 rounded">
                    <h3 class="font-semibold text-gray-700 mb-2">Poids :</h3>
                    <div id="signes-poids" class="text-gray-600 break-words leading-relaxed"></div>
                </div>

            </div>
        </div>
    </div>
</div>



<!-- Télé-expertise Modal (static placeholder) -->
<div id="teleModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-40 flex items-center justify-center">
  <div class="bg-white p-6 rounded shadow-lg w-full max-w-md">
    <h3 class="text-lg font-bold mb-4">Télé-expertise</h3>
    <div>
      <p>Fonctionnalité à venir...</p>
      <button type="button" onclick="closeModal('teleModal')" class="mt-4 px-4 py-2 rounded border">Fermer</button>
    </div>
  </div>
</div>

<script>
function openModal(id) {
  document.getElementById(id).classList.remove('hidden');
}
function closeModal(id) {
  document.getElementById(id).classList.add('hidden');
}
function openConsultationModal(patientId) {
  document.getElementById('consultationPatientId').value = patientId;
  openModal('consultationModal');
}

function openModalDossier(patientId) {
    document.getElementById('dossierId').value = patientId;
    document.getElementById('dossier-antecedents').textContent = (document.getElementById('dossier-' + patientId + '-antecedents').value || '').trim();
    document.getElementById('dossier-allergies').textContent = (document.getElementById('dossier-' + patientId + '-allergies').value || '').trim();
    document.getElementById('dossier-traitement').textContent = (document.getElementById('dossier-' + patientId + '-traitement').value || '').trim();
    openModal('dossierModal');
}

function openModalSignes(patientId) {
    document.getElementById('dossierId').value = patientId;
    document.getElementById('signes-frequenceCardiaque').textContent = (document.getElementById('signes-' + patientId + '-frequenceCardiaque').value || '').trim();
    document.getElementById('signes-frequenceRespiratoire').textContent = (document.getElementById('signes-' + patientId + '-frequenceRespiratoire').value || '').trim();
    document.getElementById('signes-tension').textContent = (document.getElementById('signes-' + patientId + '-tension').value || '').trim();
    document.getElementById('signes-temperature').textContent = (document.getElementById('signes-' + patientId + '-temperature').value || '').trim();
    document.getElementById('signes-taille').textContent = (document.getElementById('signes-' + patientId + '-taille').value || '').trim();
    document.getElementById('signes-poids').textContent = (document.getElementById('signes-' + patientId + '-poids').value || '').trim();
    openModal('signesModal');
}
</script>
</body>
</html>