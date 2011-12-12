<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%-- Include the package initialization file for preparing a review page. --%>
<%@include file="framework/includes/reviewRequestInitialization.jspf"%>

<%--
    Set the docutype to XHTML 1.0 Transitional, this is required for Review
    Request iFrame elements to be sized properly.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
    <head>
        <title><%= customerRequest.templateName() %></title>

        <%-- Include the application head content. --%>
        <%@include file="interface/fragments/applicationHeadContent.jspf" %>
        <%@include file="interface/fragments/reviewHeadContent.jspf"%>

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
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <%@include file="interface/fragments/reviewBodyContent.jspf"%>
            </div>
            
            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html>
