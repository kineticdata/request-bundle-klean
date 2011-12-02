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
        <%-- TODO: Do we want to reference customerSurvey? --%>
        <title><%= customerRequest.formName()%></title>

        <%@include file="interface/fragments/applicationHeadContent.jspf" %>
        <%@include file="interface/fragments/displayHeadContent.jspf"%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <link rel="stylesheet" href="<%= bundle.packagePath()%>/resources/css/display.css" type="text/css">

        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/datasource/datasource-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/datatable/datatable-min.js"%>"></script>
        <script type="text/javascript" src="<%=bundle.packagePath() + "/resources/js/singletable.js"%>"></script>
        <script type="text/javascript" src="<%=bundle.packagePath() + "/resources/js/twotable.js"%>"></script>
        <script type="text/javascript" src="<%=bundle.packagePath() + "/resources/js/groupeddatatable.js"%>"></script>

        <script type="text/javascript" src="<%=bundle.packagePath()%>/resources/js/display.js"></script>
    </head>

    <body class="yui-skin-sam" id="displayBody">
        <div id="bodyContainer">
            <div id="content">
                <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

                <div id="contentBody">
                    <div class="breadcrumbs">
                        <!-- Build the link to the service catalog home page.  This is
                            a static link.  -->
                        <a href="DisplayPage?srv=KS0050569A648CRdLGTgSKDuEADn0G">Service Catalog Home</a>
                        <span>></span>
                        <!-- Build the link to the portfolio description page.  The URL
                            for this page includes the instance id of the service item
                            which we are able to retrieve from the customerSurvey bean
                            attached to the request. -->
                        <a href="DisplayPage?name=PortfolioDescription&id=<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>">
                            <jsp:getProperty name="customerSurvey" property="surveyTemplateName"/>
                        </a>
                        <span>></span>
                        <!-- Build the link for the current page.  The URL for this page
                            also includes the instance id of the service item. -->
                        <a href="DisplayPage?srv=<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>">
                            <jsp:getProperty name="customerSurvey" property="surveyTemplateName"/>
                        </a>
                    </div>
                    <%@include file="../pageFragments/form.jspf" %>
                </div>

                <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
            </div>
        </div>
    </body>
</html>