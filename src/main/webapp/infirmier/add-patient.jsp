<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajouter un Patient - Infirmier</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="max-w-4xl mx-auto p-5">
        <!-- Header -->
        <div class="bg-blue-800 text-white p-6 rounded-lg mb-8 text-center">
            <h1 class="text-3xl font-bold mb-2">➕ Ajouter un Nouveau Patient</h1>
            <p class="text-gray-200">Saisir les informations du patient</p>
        </div>

        <!-- Back Button -->
        <div class="mb-6">
            <a href="<%= request.getContextPath() %>/infirmier/dashboard" class="bg-gray-600 hover:bg-gray-700 text-white px-4 py-2 rounded-lg transition-colors duration-200 flex items-center gap-2 w-fit">
                ← Retour au tableau de bord
            </a>
        </div>

        <!-- Add Patient Form -->
        <div class="bg-white rounded-lg shadow-md p-8">
            <form action="<%= request.getContextPath() %>/infirmier/dashboard" method="post" class="space-y-6">
                <!-- Personal Information Section -->
                <div class="border-b border-gray-200 pb-6">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">📋 Informations personnelles</h2>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="nom" class="block text-sm font-medium text-gray-700 mb-2">
                                Nom <span class="text-red-500">*</span>
                            </label>
                            <input type="text"
                                   id="nom"
                                   name="nom"
                                   required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>

                        <div>
                            <label for="prenom" class="block text-sm font-medium text-gray-700 mb-2">
                                Prénom <span class="text-red-500">*</span>
                            </label>
                            <input type="text"
                                   id="prenom"
                                   name="prenom"
                                   required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>

                        <div>
                            <label for="dateNaissance" class="block text-sm font-medium text-gray-700 mb-2">
                                Date de naissance <span class="text-red-500">*</span>
                            </label>
                            <input type="date"
                                   id="dateNaissance"
                                   name="dateNaissance"
                                   required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>

                        <div>
                            <label for="numSecu" class="block text-sm font-medium text-gray-700 mb-2">
                                N° Sécurité Sociale <span class="text-red-500">*</span>
                            </label>
                            <input type="text"
                                   id="numSecu"
                                   name="numSecu"
                                   required
                                   placeholder="1234567890123"
                                   maxlength="15"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                        </div>
                    </div>
                </div>

                <!-- Contact Information Section -->
                <div class="border-b border-gray-200 pb-6">
                    <h2 class="text-xl font-bold text-gray-900 mb-4"> Informations de contact</h2>

                    <div class="grid grid-cols-1 gap-6">
                        <div>
                            <label for="adresse" class="block text-sm font-medium text-gray-700 mb-2">
                                Adresse
                            </label>
                            <textarea id="adresse"
                                      name="adresse"
                                      rows="3"
                                      placeholder="Saisir l'adresse complète du patient"
                                      class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="telephone" class="block text-sm font-medium text-gray-700 mb-2">
                                    Téléphone
                                </label>
                                <input type="tel"
                                       id="telephone"
                                       name="telephone"
                                       placeholder="0612345678"
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            </div>

                            <div>
                                <label for="mutuelle" class="block text-sm font-medium text-gray-700 mb-2">
                                    Mutuelle
                                </label>
                                <input type="text"
                                       id="mutuelle"
                                       name="mutuelle"
                                       placeholder="Nom de la mutuelle"
                                       class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Status Section -->
                <div class="pb-6">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">🏥 Statut médical</h2>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-3">
                            File d'attente
                        </label>
                        <div class="space-y-2">
                            <label class="inline-flex items-center">
                                <input type="radio"
                                       name="fileAttente"
                                       value="true"
                                       checked
                                       disabled
                                       class="form-radio text-blue-600 focus:ring-blue-500">
                                <span class="ml-2 text-sm text-gray-700">En file d'attente</span>
                            </label>
                            <input type="hidden" name="fileAttente" value="true">
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="flex justify-end gap-4 pt-6 border-t border-gray-200">
                    <a href="<%= request.getContextPath() %>/infirmier/dashboard"
                       class="px-6 py-2 bg-gray-500 hover:bg-gray-600 text-white rounded-lg transition-colors duration-200">
                        Annuler
                    </a>
                    <button type="submit"
                            class="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg transition-colors duration-200 flex items-center gap-2">
                        Enregistrer le patient
                    </button>
                </div>
            </form>
        </div>

    </div>
</body>
</html>
