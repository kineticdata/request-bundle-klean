<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%-- Retrieve the Catalog --%>
<%
    // Retrieve the main catalog object
    Catalog catalog = Catalog.findByName(context, customerRequest.catalogName());
    // Preload the catalog child objects (such as Categories, Templates, etc) so
    // that they are available.  Preloading all of the related objects at once
    // is more efficient than loading them individually.
    catalog.preload(context);
%>

<!DOCTYPE html>

<html>
    <head>
        <title><%= bundle.getProperty("companyName")%> <%= bundle.getProperty("catalogName")%></title>

        <%-- Include the common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>/resources/css/catalog.css" type="text/css">

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.bundlePath()%>/libraries/jQuery/jquery-1.7.1.js"></script>
        <script type="text/javascript" src="<%=bundle.bundlePath()%>/libraries/catalogSearch/catalogSearch.js"></script>
        <script type="text/javascript" src="<%=bundle.packagePath()%>/resources/js/catalog.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <div class="header">
                    <div class="title"><%= bundle.getProperty("companyName")%> <%= bundle.getProperty("catalogName")%></div>
                    <div class="search">
                        <input id="searchInput"></input>
                        <input id="searchButton" type="button" value="Search"></inupt>
                    </div>
                    <div class="clear"></div>
                </div>

                <div id="searchResultsContainer"></div>

                <div class="categories">
                    <% CycleHelper cycle = new CycleHelper(new String[]{"odd", "even"});%>
                    <% for (Category category : catalog.getRootCategories(context)) {%>
                    <% if (category.hasTemplates()) {%>
                    <div class="categoryWrapper">
                        <div class="category">
                            <div class="name"><%= category.getName()%></div>
                            <div class="image"><%= category.getImageTag()%></div>
                            <div class="description"><%= category.getDescription()%></div>
                            <div class="clear"></div>
                            <div class="templates">
                                <% for (Template template : category.getTemplates()) {%>
                                <div class="template">
                                    <a href="<%= packageHelper.templateUrl(template.getId())%>" help="foo"><%= template.getName()%></a>
                                </div>
                                <% }%>
                            </div>
                        </div>
                    </div>
                    <% if (cycle.cycle().equals("even")) {%>
                    <div class="clear"></div>
                    <% }%>
                    <% }%>
                    <% }%>
                </div>
            </div>

            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html> 