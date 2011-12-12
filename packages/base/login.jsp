<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%--
    If the user is already logged in, redirect them to the appropriate location
    and return (this prevents the JSP content from being evaluated and
    rendered).
--%>
<%@include file="framework/includes/redirectIfLoggedIn.jspf"%>

<!DOCTYPE html>

<html>
    <head>
        <title><%= customerRequest.templateName()%></title>

        <%-- Include the application head content. --%>
        <%@include file="interface/fragments/applicationHeadContent.jspf" %>

        <%-- Include the bundle common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>/resources/css/login.css" type="text/css">

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>/resources/js/login.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <!-- Render the Login Box -->
                <div id="loginBox">
                    <!-- Login Box Header -->
                    <div class="title">Please Log In</h2>

                    <!-- Error Message -->
                    <div id="message"><%= customerRequest.errorMessage()%></div>

                    <!-- Login Form -->
                    <form name="Login" id="loginForm" method="post" action="KSAuthenticationServlet">
                        <!-- User Name -->
                        <div class="field" id="usernameField">
                            <label for="UserName">User:</label>
                            <input id="UserName" class="formField" name="UserName" type="text" autocomplete="off" >
                        </div>
                        <!-- Password -->
                        <div class="field" id="passwordField">
                            <label for="Password">Password:</label>
                            <input id="Password" class="formField" name="Password" type="password" autocomplete="off" >
                        </div>

                        <!-- Options -->
                        <div id="loginFormFooter">
                            <!-- Log In Button (manipulated on DOMReady; see header) -->
                            <input id="logInButton" name="logInButton" type="submit" value="Log In">

                            <% if (bundle.getProperty("forgotPasswordAction") != null) { %>
                            <!-- Forgot Password -->
                            <a href="<%= bundle.getProperty("forgotPasswordAction") %>" id="forgotPasswordLink">Forgot Password</a>
                            <% } %>

                            <!-- Logging In Spinner -->
                            <div class="hidden" id="loader">Authenticating... <img alt="Loading Indicator" src="<%=bundle.bundlePath()%>/resources/spinner.gif"></div>
                        </div>

                        <!-- Clear the floats -->
                        <div class="clear"></div>
                    </form>
                </div>
            </div>

            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html>