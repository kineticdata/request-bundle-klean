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

<%--
    This page must not specify an HTML doctype in order for the built in Kinetic
    display widgets to be displayed consistently in browsers.  Omitting the
    doctype declaration will force browsers to render in "Quirks" mode.  This
    mode refers to a technique used by modern browsers to mimic the behavior of
    older browsers (written before HTML doctypes existed) rather than strictly
    complying with the W3C specification for "Standards" mode.
--%>

<html>
    <head>
        <%-- TODO: Do we want to reference customerSurvey? --%>
        <title><%= customerRequest.formName()%></title>

        <%-- Include the application head content. --%>
        <%@include file="interface/fragments/applicationHeadContent.jspf" %>
        <%@include file="interface/fragments/displayHeadContent.jspf"%>

        <%-- Include the application common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>/resources/css/display.css" type="text/css">

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>/resources/js/display.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <!-- Render the log in box -->
                <div class="tertiaryColorBorder" id="loginBox">
                    <!-- Header -->
                    <h2 class="auxiliaryTitleColor">Please Log In</h2>

                    <!-- Empty message div (this is automatically populated with 
                         Kinetic Request messages; such as when a user logs out
                         or enters an incorrect password). -->
                    <div id="message"></div>

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
                        <!-- Authentication -->
                        <div class="field" id="authenticationField">
                            <label for="Authentication">Authentication:</label>
                            <input class="formField" name="Authentication" type="text" id="Authentication">
                        </div>

                        <!-- Options -->
                        <div id="loginFormFooter">
                            <!-- Log In Button (manipulated on DOMReady; see header) -->
                            <input id="logInButton" name="logInButton" type="submit" value="Log In">

                            <% if (bundle.getProperty("forgotPasswordAction") != null) { %>
                            <!-- Forgot Password -->
                            <a class="primaryColor" href="<%= bundle.getProperty("forgotPasswordAction") %>" id="forgotPasswordLink">Forgot Password</a>
                            <% } %>

                            <!-- Logging In Spinner -->
                            <div class="hidden" id="loader">Authenticating... <img alt="Loading Indicator" src="<%=bundle.bundlePath()%>/resources/spinner.gif"></div>
                        </div>

                        <!-- Specify the required hidden elements.  The value of these are set by kd_client.js on page load. -->
                        <input type="hidden" name="originatingPage" id="originatingPage">
                        <input type="hidden" name="sessionID" id="loginSessionID">
                        <input type="hidden" name="authenticationType" id="authenticationType">

                        <!-- Clear the floats -->
                        <div class="clear"></div>
                    </form>
                </div>

                <%@include file="interface/fragments/displayBodyContent.jspf"%>
            </div>

            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html>