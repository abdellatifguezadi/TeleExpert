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
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <%
                for (Consultation consultation : consultations) {
                    String modalId = "modal_" + consultation.getId();
            %>
            <div class="bg-white rounded-2xl shadow-xl border border-blue-200 p-6 flex flex-col gap-4">
                <div class="flex flex-col gap-2 text-base">
                    <div><span class="font-semibold text-blue-700">ID :</span> <span class="text-gray-800">#<%= consultation.getId() %></span></div>
                    <div><span class="font-semibold text-blue-700">Motif :</span> <span class="text-gray-800"><%= consultation.getMotif() != null ? consultation.getMotif() : "Non spécifié" %></span></div>
                    <div><span class="font-semibold text-blue-700">Status :</span>
                        <span class="text-gray-800">
                            <%= consultation.getStatus() != null ? consultation.getStatus() : "Non défini" %>
                        </span>
                    </div>
                    <div><span class="font-semibold text-blue-700">Date :</span>
                        <span class="text-gray-800">
                            <%= consultation.getDateConsultation() != null ? consultation.getDateConsultation().format(formatter) : "Non définie" %>
                        </span>
                    </div>
                </div>
                <button onclick="openModal('<%= modalId %>')" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-bold shadow transition self-end">Afficher</button>
            </div>
            <% } %>
        </div>

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
                    </div>
                </div>
            </div>
        </div>
        <% } %>

        <% } else { %>
        <!-- Message si aucune consultation -->
        <div class="bg-white rounded-2xl shadow-xl border border-blue-200 p-8 text-center">
            <div class="text-gray-500 text-lg">
                <svg class="w-16 h-16 mx-auto mb-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
                <p class="text-xl font-semibold text-gray-600 mb-2">Aucune consultation trouvée</p>
                <p class="text-gray-500">Ce patient n'a pas encore de consultations enregistrées.</p>
            </div>
        </div>
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
