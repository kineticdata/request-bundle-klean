<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%-- Include the catalog initialization file. --%>
<%@include file="framework/includes/catalogInitialization.jspf"%>

<!DOCTYPE html>

<html>
    <head>
        <title><%= bundle.getProperty("companyName")%> <%= bundle.getProperty("portalName")%></title>

        <%-- Include the common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>/resources/css/portal.css" type="text/css">

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>/resources/js/portal.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <div class="title"><%= bundle.getProperty("companyName")%> <%= bundle.getProperty("portalName")%></div>

                <div class="categories">
                    <% for (Category category : catalog.getRootCategories(context)) { %>
                    <% if (category.hasTemplates()) { %>
                    <div class="category">
                        <div class="name"><%= category.getName()%></div>
                        <div class="templates">
                            <% for (Template template : category.getTemplates()) { %>
                            <div class="template">
                                <a href="<%= packageHelper.templateUrl(template.getId())%>"><%= template.getName()%></a>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                    <% } %>
                </div>
            </div>

            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html> 