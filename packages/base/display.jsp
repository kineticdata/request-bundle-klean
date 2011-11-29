<%-- Specify the HTML5 Doctype --%>
<!DOCTYPE html>

<%-- Include the package intitialization file. --%>
<%@include file="jsp/includes/base.jspf"%>

<html>
    <%@include file="../includes/application/headerContent.jsp"%>
    <%@include file="../includes/application/formListeners.jspf"%>
    <body class="yui-skin-sam">
        <div id="bodyContainer">
            <div id="display">
                <div class="displayHeader">
                    <%@include file="../shared/header.jspf"%>
                </div>
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
                <div class="displayContent">
                    <%@include file="../pageFragments/form.jspf" %>
                </div>
                <%@include file="../shared/footer.jspf"%>
            </div>
        </div>
    </body>
</html>