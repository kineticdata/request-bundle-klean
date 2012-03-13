<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the bundle initialization file. --%>
<%@include file="../../core/framework/includes/bundleInitialization.jspf"%>

<%-- 
    Include the CatalogSearch fragment that defines the CatalogSearch class that
    will be used to retrieve and filter the catalog data.
--%>
<%@include file="CatalogSearch.jspf"%>

<%
    /*
     * Clear the output stream to remove any newlines inserted before and after
     * the initialization comments.
     */
    out.clearBuffer();

    /*
     * The following code accepts the HTTP parameter "query", breaks it into
     * querySegments (by splitting on the space character), and replaces
     */
    String catalogName = request.getParameter("catalogName");

    // Build the array of querySegments (query string separated by a space)
    String[] querySegments = request.getParameter("query").split(" ");

    // Display an error message if there are 0 querySegments or > 10 querySegments
    if (querySegments.length == 0 || querySegments[0].length() == 0) {
        out.println("<div class=\"message\">Error: Please enter a search term.</div>");
    } else if (querySegments.length > 10) {
        out.println("<div class=\"message\">Error: Search is limited to 10 search terms.</div>");
    } else {
        // Retrieve the searchableAttribute property
        String searchableAttributeString = bundle.getProperty("searchableAttributes");
        // Default the searchableAttribute property to "Keyword" if it wasn't specified
        if (searchableAttributeString == null) {searchableAttributeString = "Keyword";}
        // Initialize the searchable attributes array
        String[] searchableAttributes = new String[0];
        // If the searchableAttributeString is not empty
        if (!searchableAttributeString.equals("")) {
            searchableAttributes = searchableAttributeString.split("\\s*,\\s*");
        }
        CatalogSearch catalogSearch = new CatalogSearch(context, catalogName, querySegments);
        //Category[] matchingCategories = catalogSearch.getMatchingCategories();
        Template[] matchingTemplates = catalogSearch.getMatchingTemplates(searchableAttributes);
        Pattern combinedPattern = catalogSearch.getCombinedPattern();
        if (matchingTemplates.length == 0) {
            out.println("<div class=\"message\">No results were found.</div>");
        } else {
%>
<div class="templates">
    <% for (int i = 0; i < matchingTemplates.length; i++) {%>
    <div class="template">
        <div class="templateName">
            <a href="DisplayPage?srv=<%= matchingTemplates[i].getId()%>">
                <%= CatalogSearch.replaceAll(combinedPattern, matchingTemplates[i].getName())%>
            </a>
        </div>

        <div class="templateDescription"><%= CatalogSearch.replaceAll(combinedPattern, matchingTemplates[i].getDescription())%></div>
        <div class="attributes">
            <% for (String attributeName : searchableAttributes) {%>
            <div class="attribute">
                <div class="attributeName"><%= attributeName %></div>
                <div class="attributeValues">
                    <% for (String attributeValue : matchingTemplates[i].getTemplateAttributeValues(attributeName)) {%>
                    <div class="attributeValue"><%= CatalogSearch.replaceAll(combinedPattern, attributeValue)%></div>
                    <% }%>
                    <div class="clear"></div>
                </div>
            </div>
            <% }%>
            <div class="clear"></div>
        </div>
    </div>
    <% }%>
    <div class="clear"></div>
</div>
<%
    }
}
%>