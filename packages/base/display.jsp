<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

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
        <title><%= customerRequest.templateName()%></title>

        <%-- Include the application head content. --%>
        <%@include file="interface/fragments/applicationHeadContent.jspf" %>
        <%@include file="interface/fragments/displayHeadContent.jspf"%>

        <%-- Include the bundle common content. --%>
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
                <%@include file="interface/fragments/displayBodyContent.jspf"%>
            </div>

            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html>