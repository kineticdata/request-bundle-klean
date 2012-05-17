<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file for preparing a review page. --%>
<%@include file="framework/includes/reviewRequestInitialization.jspf"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%--
    Set the docutype to XHTML 1.0 Transitional, this is required for Review
    Request iFrame elements to be sized properly.
--%>
<!DOCTYPE html>

<html>
    <head>
        <%-- Include the application head content. --%>
        <%@include file="../../core/interface/fragments/applicationHeadContent.jspf" %>
        <%@include file="../../core/interface/fragments/reviewHeadContent.jspf"%>

        <%-- Include the bundle common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/display.css" type="text/css">
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/review.css" type="text/css">

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/display.js"></script>
    </head>

    <body class="loadAllPages_<%=customerSurveyReview.getLoadAllPages()%>">
        <div id="bodyContainer">
            <%@include file="../../core/interface/fragments/reviewBodyContent.jspf"%>
        </div>
    </body>
</html>
