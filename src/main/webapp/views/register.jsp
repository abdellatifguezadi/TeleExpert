<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TeleExpertise - Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-blue-500 to-blue-600 flex items-center justify-center font-sans py-5">
    <div class="bg-white p-8 rounded-lg shadow-2xl w-full max-w-lg">
        <div class="text-center mb-8">
            <h1 class="text-gray-800 text-2xl font-bold mb-2">TeleExpertise</h1>
            <p class="text-gray-600 text-sm">Create your account to get started with healthcare expertise.</p>
        </div>


        <c:if test="${not empty error}">
            <div class="bg-blue-100 border border-blue-300 text-blue-800 px-4 py-3 rounded mb-4">
                ${error}
            </div>
        </c:if>

<%--        <% if (request.getAttribute("error") != null) { %>--%>
<%--            <div class="bg-blue-100 border border-blue-300 text-blue-800 px-4 py-3 rounded mb-4">--%>
<%--                <%= request.getAttribute("error") %>--%>
<%--            </div>--%>
<%--        <% } %>--%>


        <c:if test="${not empty success}">
            <div class="bg-green-100 border border-green-300 text-green-800 px-4 py-3 rounded mb-4">
                ${success}
            </div>
        </c:if>

<%--        <% if (request.getAttribute("success") != null) { %>--%>
<%--            <div class="bg-green-100 border border-green-300 text-green-800 px-4 py-3 rounded mb-4">--%>
<%--                <%= request.getAttribute("success") %>--%>
<%--            </div>--%>
<%--        <% } %>--%>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="flex gap-4 md:flex-row flex-col">
                <div class="flex-1 mb-6">
                    <label for="nom" class="block mb-2 text-gray-800 font-medium">First Name *</label>
                    <input type="text" id="nom" name="nom" requiblue
                           placeholder="Enter your first name"
                           class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
                </div>

                <div class="flex-1 mb-6">
                    <label for="prenom" class="block mb-2 text-gray-800 font-medium">Last Name *</label>
                    <input type="text" id="prenom" name="prenom" requiblue
                           placeholder="Enter your last name"
                           class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
                </div>
            </div>

            <div class="mb-6">
                <label for="email" class="block mb-2 text-gray-800 font-medium">Email Address *</label>
                <input type="email" id="email" name="email" requiblue
                       placeholder="Enter your email address"
                       class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
            </div>

            <div class="flex gap-4 md:flex-row flex-col">
                <div class="flex-1 mb-6">
                    <label for="motDePasse" class="block mb-2 text-gray-800 font-medium">Password *</label>
                    <input type="password" id="motDePasse" name="motDePasse" requiblue minlength="6"
                           placeholder="Enter your password"
                           class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
                </div>

                <div class="flex-1 mb-6">
                    <label for="confirmPassword" class="block mb-2 text-gray-800 font-medium">Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" requiblue minlength="6"
                           placeholder="Confirm your password"
                           class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
                </div>
            </div>

            <div class="mb-6">
                <label for="role" class="block mb-2 text-gray-800 font-medium">Professional Role *</label>
                <select id="role" name="role" requiblue
                        class="w-full px-3 py-3 border-2 border-gray-200 rounded-md text-base transition-colors duration-300 focus:outline-none focus:border-blue-500">
                    <option value="">Select your role</option>
                    <option value="INFIRMIER">Nurse</option>
                    <option value="GENERALISTE">Doctor Generalist</option>
                    <option value="SPECIALISTE">Doctor Specialist</option>
                    <option value="ADMIN">Administrator</option>
                </select>
            </div>

            <button type="submit" class="w-full py-3 bg-gradient-to-r from-blue-500 to-blue-600 text-white border-none rounded-md text-base font-semibold cursor-pointer transition-transform duration-200 hover:-translate-y-1">
                Create Account
            </button>
        </form>

        <div class="text-center mt-6 pt-6 border-t border-gray-200">
            <p>Already have an account? <a href="login" class="text-blue-500 no-underline font-medium hover:underline">Sign in here</a></p>
        </div>
    </div>

    <script>
        // Client-side validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('motDePasse').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }

            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return false;
            }
        });
    </script>
</body>
</html>
