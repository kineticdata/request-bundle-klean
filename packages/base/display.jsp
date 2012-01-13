<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<!DOCTYPE html>

<html>
    <head>
        <title><%= customerRequest.templateName()%></title>

        <%-- Include the application head content. --%>
        <%@include file="../../core/interface/fragments/applicationHeadContent.jspf" %>
        <%@include file="../../core/interface/fragments/displayHeadContent.jspf"%>

        <%-- Include the bundle common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/display.css" type="text/css">

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/display.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <%@include file="../../core/interface/fragments/displayBodyContent.jspf"%>
            </div>

            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html>