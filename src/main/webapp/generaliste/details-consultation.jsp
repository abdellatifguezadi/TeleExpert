<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.teleexpertise.model.Consultation" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails Consultation</title>
    <script src="https://cdn.tailwindcss.com"></script>

</head>
<body class="min-h-screen bg-gradient-to-br from-blue-100 via-white to-blue-200 flex flex-col items-center py-12">
    <div class="w-full max-w-4xl px-4">
        <h1 class="text-3xl font-extrabold text-blue-700 mb-10 text-center drop-shadow">Détails des Consultations</h1>

        <%
            List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            if (consultations != null && !consultations.isEmpty()) {
        %>
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
                <% for (Consultation consultation : consultations) {
                    String modalId = "modal_" + consultation.getId();
                %>
                <tr class="border-b hover:bg-blue-50">
                    <td class="py-2 px-4">#<%= consultation.getId() %></td>
                    <td class="py-2 px-4"><%= consultation.getMotif() != null ? consultation.getMotif() : "Non spécifié" %></td>
                    <td class="py-2 px-4"><%= consultation.getStatus() != null ? consultation.getStatus() : "Non défini" %></td>
                    <td class="py-2 px-4"><%= consultation.getDateConsultation() != null ? consultation.getDateConsultation().format(formatter) : "Non définie" %></td>
                    <td class="py-2 px-4">
                        <div class="flex flex-row items-center gap-2">
                            <button onclick="openModal('<%= modalId %>')" class="bg-blue-600 hover:bg-blue-700 text-white px-3 py-1 rounded font-bold shadow transition text-xs">Afficher</button>
                            <select name="status" form="form-<%= consultation.getId() %>" class="border rounded px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-400">
                                <option value="EN_ATTENTE" <%= (consultation.getStatus() == null || "EN_ATTENTE".equals(consultation.getStatus().toString())) ? "selected" : "" %>>En attente</option>
                                <option value="TERMINEE" <%= "TERMINEE".equals(consultation.getStatus() != null ? consultation.getStatus().toString() : "") ? "selected" : "" %>>Clôturée</option>
                                <option value="EN_ATTENTE_EXPERTISE" <%= "EN_ATTENTE_EXPERTISE".equals(consultation.getStatus() != null ? consultation.getStatus().toString() : "") ? "selected" : "" %>>En attente demande d'expertise</option>
                            </select>
                            <form id="form-<%= consultation.getId() %>" method="post" action="<%= request.getContextPath() + "/generaliste/consultation" %>" class="inline">
                                <input type="hidden" name="consultationId" value="<%= consultation.getId() %>" />
                                <input type="hidden" name="patientId" value="<%= request.getAttribute("patientId") %>" />
                                <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-3 py-1 rounded font-bold shadow transition text-xs align-middle leading-none self-center" style="margin-top:0;">Valider</button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Modales pour les détails -->
        <%
            for (Consultation consultation : consultations) {
                String modalId = "modal_" + consultation.getId();
        %>
        <!-- Modale pour consultation ID: <%= consultation.getId() %> -->
        <div id="<%= modalId %>" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
            <div class="bg-white rounded-lg shadow-lg p-6 max-w-2xl w-full relative max-h-[80vh] overflow-y-auto mx-4">
                <button onclick="closeModal('<%= modalId %>')" class="absolute top-3 right-3 text-gray-500 hover:text-gray-700 text-2xl font-bold">&times;</button>
                <div class="pr-8">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 border-b border-gray-200 pb-2">
                        Consultation #<%= consultation.getId() %>
                    </h2>
                    <div class="space-y-4">
                        <!-- Diagnostic -->
                        <div class="border border-gray-200 p-4 rounded">
                            <h3 class="font-semibold text-gray-700 mb-2">Diagnostic :</h3>
                            <div class="text-gray-600 break-words leading-relaxed">
                                <%= consultation.getDiagnostic() != null ? consultation.getDiagnostic().trim() : "" %>
                            </div>
                        </div>

                        <!-- Traitement -->
                        <div class="border border-gray-200 p-4 rounded">
                            <h3 class="font-semibold text-gray-700 mb-2">Traitement :</h3>
                            <div class="text-gray-600 break-words leading-relaxed">
                                <%= consultation.getTraitement() != null ? consultation.getTraitement().trim() : "" %>
                            </div>
                        </div>

                        <!-- Observations -->
                        <div class="border border-gray-200 p-4 rounded">
                            <h3 class="font-semibold text-gray-700 mb-2">Observations :</h3>
                            <div class="text-gray-600 break-words leading-relaxed">
                                <%= consultation.getObservations() != null ? consultation.getObservations().trim() : "" %>
                            </div>
                        </div>

                        <% if (consultation.getStatus() != null && "TERMINEE".equals(consultation.getStatus().toString())) { %>
                        <div class="mt-4 text-green-700 font-bold">Consultation clôturée</div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <p class="text-xl font-semibold text-gray-600 mb-2">Aucune consultation trouvée</p>
        <p class="text-gray-500">Ce patient n'a pas encore de consultations enregistrées.</p>
        <% } %>

        <!-- Bouton de retour -->
        <div class="mt-8 text-center">
            <a href="<%= request.getContextPath() %>/generaliste/dashboard" class="bg-gray-600 hover:bg-gray-700 text-white px-6 py-3 rounded-lg font-bold shadow transition">
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

</body>
</html>
