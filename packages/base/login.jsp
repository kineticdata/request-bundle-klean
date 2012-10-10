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
        <meta charset="utf-8">
        <title><%= customerRequest.getTemplateName()%></title>

        <%-- Include the application head content. --%>
        <%@include file="../../core/interface/fragments/applicationHeadContent.jspf" %>

        <%-- Include the bundle common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/login.css" type="text/css" />
        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/login.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <!-- Render the Login Box -->
                <div id="loginBox">
                    <!-- Login Box Header -->
                    <div class="title">Please Log In</div>

                    <!-- Error Message -->
                    <div class="message"><%= customerRequest.clearErrorMessage()%></div>

                    <!-- Login Form -->
                    <form name="Login" id="loginForm" method="post" action="KSAuthenticationServlet">
                        <!-- User Name -->
                        <div class="field" id="usernameField">
                            <div class="label"><label for="UserName">User:</label></div>
                            <div class="value"><input id="UserName" class="formField" name="UserName" type="text" autocomplete="off" /></div>
                            <div class="clear"></div>
                        </div>
                        <!-- Password -->
                        <div class="field" id="passwordField">
                            <div class="label"><label for="Password">Password:</label></div>
                            <div class="value"><input id="Password" class="formField" name="Password" type="password" autocomplete="off" /></div>
                            <div class="clear"></div>
                        </div>

                        <!-- Options -->
                        <div id="loginFormFooter">
                            <!-- Log In Button (manipulated on DOMReady; see header) -->
                            <input id="logInButton" name="logInButton" type="submit" value="Log In">

                            <% if (bundle.getProperty("forgotPasswordAction") != null) {%>
                            <!-- Forgot Password -->
                            <a href="<%= bundle.getProperty("forgotPasswordAction")%>" id="forgotPasswordLink">Forgot Password</a>
                            <% }%>

                            <!-- Logging In Spinner -->
                            <div class="hidden" id="loader">Authenticating... <img alt="Loading Indicator" src="<%=bundle.bundlePath()%>common/resources/images/spinner_00427E_FFFFFF.gif"></div>
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