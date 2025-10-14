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
    <p class="text-lg">Bienvenue, <strong>Dr. Ahmed (Cardiologue)</strong></p>
</header>

<!-- Contenu principal -->
<main class="max-w-5xl mx-auto mt-8 space-y-8">

    <!-- Section Profil -->
    <section class="bg-white p-6 rounded-2xl shadow-md">
        <h2 class="text-2xl font-semibold mb-4 text-blue-700">Profil du Spécialiste</h2>
        <ul class="text-gray-700 space-y-2">
            <li><strong>Nom :</strong> Dr. Ahmed</li>
            <li><strong>Spécialité :</strong> Cardiologue</li>
            <li><strong>Tarif :</strong> 400 DH</li>
            <li><strong>Durée moyenne de consultation :</strong> 30 min</li>
        </ul>
    </section>

    <!-- Section Créneaux disponibles -->
    <section class="bg-white p-6 rounded-2xl shadow-md">
        <h2 class="text-2xl font-semibold mb-4 text-blue-700">Créneaux disponibles</h2>
        <div class="space-y-2">
            <p>09h00 - 09h30  Disponible</p>
            <p>09h30 - 10h00  Disponible</p>
            <p>10h00 - 10h30  Disponible</p>
            <p>10h30 - 11h00  Reserve</p>
            <p>11h00 - 11h30  Disponible</p>
            <p>11h30 - 12h00  Disponible</p>
        </div>
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
                <tr class="border-b hover:bg-gray-50">
                    <td class="py-2 px-4">Fatima Zahra</td>
                    <td class="py-2 px-4 text-yellow-600 font-semibold">Urgente</td>
                    <td class="py-2 px-4">Interpretation d’un electrocardiogramme</td>
                    <td class="py-2 px-4">En attente</td>
                    <td class="py-2 px-4 text-center">
                        <div class="flex flex-row items-center justify-center gap-2">
                            <button onclick="showModal('Fatima Zahra')" class="bg-blue-600 text-white px-2 py-1 rounded text-xs hover:bg-blue-700">Repondre</button>
                            <button onclick="showConsultation('Fatima Zahra')" class="bg-green-600 text-white px-2 py-1 rounded text-xs hover:bg-green-700">Voir Consultation</button>
                            <button onclick="showSignesVitaux('Fatima Zahra')" class="bg-purple-600 text-white px-2 py-1 rounded text-xs hover:bg-purple-700">Voir Signes Vitaux</button>
                        </div>
                    </td>
                </tr>
                <tr class="border-b hover:bg-gray-50">
                    <td class="py-2 px-4">Youssef El Idrissi</td>
                    <td class="py-2 px-4 text-green-600 font-semibold">Normale</td>
                    <td class="py-2 px-4">Diagnostic d’hypertension</td>
                    <td class="py-2 px-4">Terminee</td>
                    <td class="py-2 px-4 text-center">
                        <div class="flex flex-row items-center justify-center gap-2">
                            <button disabled class="bg-gray-400 text-white px-2 py-1 rounded text-xs cursor-not-allowed">Repondre</button>
                            <button onclick="showConsultation('Youssef El Idrissi')" class="bg-green-600 text-white px-2 py-1 rounded text-xs hover:bg-green-700">Voir Consultation</button>
                            <button onclick="showSignesVitaux('Youssef El Idrissi')" class="bg-purple-600 text-white px-2 py-1 rounded text-xs hover:bg-purple-700">Voir Signes Vitaux</button>
                        </div>
                    </td>
                </tr>
                <tr class="hover:bg-gray-50">
                    <td class="py-2 px-4">Sara Bensaid</td>
                    <td class="py-2 px-4 text-red-600 font-semibold">Critique</td>
                    <td class="py-2 px-4">evaluation d’un cas de tachycardie</td>
                    <td class="py-2 px-4">En cours</td>
                    <td class="py-2 px-4 text-center">
                        <div class="flex flex-row items-center justify-center gap-2">
                            <button onclick="showModal('Sara Bensaid')" class="bg-blue-600 text-white px-2 py-1 rounded text-xs hover:bg-blue-700">Repondre</button>
                            <button onclick="showConsultation('Sara Bensaid')" class="bg-green-600 text-white px-2 py-1 rounded text-xs hover:bg-green-700">Voir Consultation</button>
                            <button onclick="showSignesVitaux('Sara Bensaid')" class="bg-purple-600 text-white px-2 py-1 rounded text-xs hover:bg-purple-700">Voir Signes Vitaux</button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </section>

</main>

<!-- Modal Reponse -->
<div id="modal" class="hidden fixed inset-0 bg-gray-800 bg-opacity-60 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-full max-w-lg">
        <h2 class="text-2xl font-semibold mb-4 text-blue-700">Repondre a une Expertise</h2>
        <form class="space-y-4">
            <div>
                <label class="block text-gray-700">Patient</label>
                <input id="modal-patient" type="text" class="w-full border rounded-lg px-3 py-2 mt-1" readonly>
            </div>
            <div>
                <label class="block text-gray-700">Avis medical</label>
                <textarea class="w-full border rounded-lg px-3 py-2 mt-1" rows="4" placeholder="Saisir l'avis du specialiste..."></textarea>
            </div>
            <div>
                <label class="block text-gray-700">Recommandations</label>
                <textarea class="w-full border rounded-lg px-3 py-2 mt-1" rows="3" placeholder="Saisir les recommandations..."></textarea>
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" onclick="hideModal()" class="bg-gray-400 text-white px-6 py-2 rounded-lg hover:bg-gray-500 transition">Annuler</button>
                <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition">Marquer comme Terminee</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Consultation -->
<div id="modal-consultation" class="hidden fixed inset-0 bg-gray-800 bg-opacity-60 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-full max-w-lg">
        <h2 class="text-2xl font-semibold mb-4 text-green-700">Consultation</h2>
        <div class="space-y-4">
            <div>
                <span class="block text-gray-700 font-semibold">Patient :</span>
                <span id="consultation-patient" class="block text-gray-900"></span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Date de consultation :</span>
                <span class="block text-gray-900">13/10/2025</span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Diagnostic :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Traitement :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Observations :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" onclick="hideConsultationModal()" class="bg-gray-400 text-white px-6 py-2 rounded-lg hover:bg-gray-500 transition">Fermer</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Signes Vitaux -->
<div id="modal-signes" class="hidden fixed inset-0 bg-gray-800 bg-opacity-60 flex items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-full max-w-lg">
        <h2 class="text-2xl font-semibold mb-4 text-purple-700">Signes Vitaux</h2>
        <div class="space-y-4">
            <div>
                <span class="block text-gray-700 font-semibold">Patient :</span>
                <span id="signes-patient" class="block text-gray-900"></span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Fréquence cardiaque :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Tension :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Température :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Poids :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div>
                <span class="block text-gray-700 font-semibold">Taille :</span>
                <span class="block text-gray-900">-</span>
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" onclick="hideSignesModal()" class="bg-gray-400 text-white px-6 py-2 rounded-lg hover:bg-gray-500 transition">Fermer</button>
            </div>
        </div>
    </div>
</div>

<footer class="text-center py-6 text-gray-500 mt-10">
    <p>&copy; 2025 Tele-Expertise Medicale - Tous droits reserves</p>
</footer>

<script>
    function showModal(patientName) {
        document.getElementById('modal').classList.remove('hidden');
        document.getElementById('modal-patient').value = patientName;
    }

    function hideModal() {
        document.getElementById('modal').classList.add('hidden');
    }

    function showConsultation(patientName) {
        document.getElementById('consultation-patient').textContent = patientName;
        document.getElementById('modal-consultation').classList.remove('hidden');
    }
    function hideConsultationModal() {
        document.getElementById('modal-consultation').classList.add('hidden');
    }
    function showSignesVitaux(patientName) {
        document.getElementById('signes-patient').textContent = patientName;
        document.getElementById('modal-signes').classList.remove('hidden');
    }
    function hideSignesModal() {
        document.getElementById('modal-signes').classList.add('hidden');
    }
</script>

</body>
</html>
