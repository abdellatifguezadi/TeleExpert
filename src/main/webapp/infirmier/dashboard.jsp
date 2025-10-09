<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.teleexpertise.model.Patient" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<html>
<head>
    <title>Tableau de bord - Infirmier</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="max-w-7xl mx-auto p-5">
        <!-- Header -->
        <div class="bg-blue-800 text-white p-6 rounded-lg mb-8 text-center">
            <h1 class="text-3xl font-bold mb-2">🏥 Tableau de bord - Infirmier</h1>
            <p class="text-gray-200">Gestion des patients et soins infirmiers</p>
        </div>


        <!-- Actions Bar -->
        <div class="bg-white p-4 rounded-lg shadow-md mb-6 flex justify-end">
            <div class="flex gap-3">
                <a href="<%= request.getContextPath() %>/infirmier/add-patient" class="bg-green-600 hover:bg-green-700 text-white px-5 py-2 rounded-lg transition-colors duration-200 flex items-center gap-2">
                     Ajouter un Patient
                </a>
                <a href="#" class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg transition-colors duration-200 flex items-center gap-2">
                     Rapport journalier
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
                        <%
                            List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                            if (patients != null && !patients.isEmpty()) {
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                                for (Patient patient : patients) {
                        %>
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-4 py-3 text-sm text-gray-900">#<%= patient.getId() %></td>
                                        <td class="px-4 py-3 text-sm font-medium text-gray-900"><%= patient.getNom() %> <%= patient.getPrenom() %></td>
                                        <td class="px-4 py-3 text-sm text-gray-900">
                                            <%= patient.getDateNaissance() != null ? patient.getDateNaissance().format(formatter) : "" %>
                                        </td>
                                        <td class="px-4 py-3 text-sm text-gray-900"><%= patient.getNumSecu() %></td>
                                        <td class="px-4 py-3 text-sm text-gray-900"><%= patient.getTelephone() %></td>
                                        <td class="px-4 py-3 text-sm text-gray-900"><%= patient.getMutuelle() != null ? patient.getMutuelle() : "Non renseigné" %></td>
                                        <td class="px-4 py-3 text-sm">
                                            <%
                                                if (patient.getFileAttente() != null && patient.getFileAttente()) {
                                            %>
                                                    <span class="inline-flex px-3 py-1 text-xs font-semibold rounded-full bg-yellow-500 text-white">
                                                        En attente
                                                    </span>
                                            <%
                                                } else {
                                            %>
                                                    <span class="inline-flex px-3 py-1 text-xs font-semibold rounded-full bg-green-500 text-white">
                                                        Disponible
                                                    </span>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td class="px-4 py-3 text-sm">
                                            <div class="flex gap-2">
                                                <a href="add-signesvitaux.jsp?id=<%= patient.getId() %>" class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-xs transition-colors">
                                                     ajoute signes vitaux
                                                </a>
                                                <a href="edit-dossiermedical.jsp?id=<%= patient.getId() %>" class="bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded text-xs transition-colors">
                                                     ajoute dossier medical
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                        <%
                                }
                            } else {
                        %>
                                <tr>
                                    <td colspan="8" class="px-4 py-12 text-center text-gray-500">
                                        <div>
                                            <h3 class="text-lg font-medium mb-2">Aucun patient enregistré</h3>
                                            <p class="text-sm">Commencez par ajouter votre premier patient en cliquant sur le bouton "Ajouter un Patient"</p>
                                        </div>
                                    </td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
