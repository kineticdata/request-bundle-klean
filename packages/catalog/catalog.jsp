<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%-- Retrieve the Catalog --%>
<%
    // Retrieve the main catalog object
    Catalog catalog = Catalog.findByName(context, customerRequest.getCatalogName());
    // Preload the catalog child objects (such as Categories, Templates, etc) so
    // that they are available.  Preloading all of the related objects at once
    // is more efficient than loading them individually.
    catalog.preload(context);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title><%= bundle.getProperty("companyName") + " " + bundle.getProperty("catalogName")%></title>

        <%-- Include the common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/catalog.css" type="text/css" />
        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/catalogSearch.js"></script>
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/catalog.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>

            <div id="contentBody">
                <div class="header">
                    <div class="breadcrumbs">
                        <div id="homeActive"class="link active">
                            <%= bundle.getProperty("catalogName")%>
                        </div>
                        <div id="homeInactive" class="link">
                            <a href="javascript:void(0)"><%= bundle.getProperty("catalogName")%></a>
                        </div>
                        <div id="divider">/</div>
                        <div id="searchActive" class="link active">
                            Search Results: "<span class="searchValue"></span>"
                        </div>
                        <div class="clear"></div>
                    </div>
                    <form id="catalogSearchForm" method="get" action="<%= bundle.packagePath()%>interface/callbacks/catalogSearch.html.jsp">
                        <input type="hidden" name="catalogName" value="<%= bundle.getProperty("catalogName")%>" />
                        <p class="search">
                            <label for="searchInput"></label>
                            <input type="search" name="query" id="searchInput" value="" />
                            <input type="submit" id="searchButton" value="Search" />
                        </p>
                    </form>
                    <div class="clear"></div>
                </div>

                <div id="searchSpinner">
                    Searching for "<span class="searchValue"></span>"
                    <img alt="Loading..." src="<%= bundle.bundlePath%>common/resources/images/spinner_00427E_FFFFFF.gif"></img>
                </div>
                <div id="searchResults">
                </div>

                <div id="catalogContainer">
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
                                    <a href="<%= pathHelper.templateUrl(template.getId())%>"><%= template.getName()%></a>
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