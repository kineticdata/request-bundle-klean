<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title><%= bundle.getProperty("companyName") + " " + bundle.getProperty("catalogName")%></title>

        <%-- Include the common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/scaffold.css" type="text/css" />

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/scaffold.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>
            <div id="contentBody">
                Scaffold
            </div>
            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html> 