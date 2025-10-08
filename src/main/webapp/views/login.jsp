<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TeleExpertise - Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-blue-500 to-blue-600 flex items-center justify-center font-sans">
    <div class="bg-white p-8 rounded-lg shadow-2xl w-full max-w-md">
        <div class="text-center mb-8">
            <h1 class="text-gray-800 text-2xl font-bold mb-2">TeleExpertise</h1>
            <p class="text-gray-600 text-sm">Welcome back! Please sign in to your account.</p>
        </div>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="bg-red-100 border border-red-300 text-red-800 px-4 py-3 rounded mb-4">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="mb-6">
                <label for="email" class="block mb-2 text-gray-800 font-medium">Email Address</label>
                <input type="email" id="email" name="email" required
                       placeholder="Enter your email address"
                       class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
            </div>

            <div class="mb-6">
                <label for="motDePasse" class="block mb-2 text-gray-800 font-medium">Password</label>
                <input type="password" id="motDePasse" name="motDePasse" required
                       placeholder="Enter your password"
                       class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
            </div>

            <button type="submit" class="w-full py-3 bg-gradient-to-r from-blue-500 to-blue-600 text-white border-none rounded-md text-base font-semibold cursor-pointer transition-transform duration-200 hover:-translate-y-1">
                Sign In
            </button>
        </form>

        <div class="text-center mt-6 pt-6 border-t border-gray-200">
            <p>Don't have an account? <a href="register" class="text-blue-500 no-underline font-medium hover:underline">Create one here</a></p>
        </div>
    </div>
</body>
</html>
