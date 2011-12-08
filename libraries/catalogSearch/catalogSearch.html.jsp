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
        out.println("<div>Error: Please enter a search term.</div>");
    } else if (querySegments.length > 10) {
        out.println("<div>Error: Search is limited to 10 search terms.</div>");
    } else {
        bundle.setProperty("searchableAttributes", "Keyword,Expiration Days");
        String[] searchableAttributes = bundle.getProperty("searchableAttributes").split("\\s*,\\s*");
        CatalogSearch catalogSearch = new CatalogSearch(context, catalogName, querySegments);
        Category[] matchingCategories = catalogSearch.getMatchingCategories();
        Template[] matchingTemplates = catalogSearch.getMatchingTemplates(searchableAttributes);
        Pattern combinedPattern = catalogSearch.getCombinedPattern();
%>
<div class="templates">
    <% for (int i = 0; i < matchingTemplates.length; i++) {%>
    <div class="template">
        <div class="templateName"><%= CatalogSearch.replaceAll(combinedPattern, matchingTemplates[i].getName())%></div>
        <div class="templateDescription"><%= CatalogSearch.replaceAll(combinedPattern, matchingTemplates[i].getDescription())%></div>
        <% String[] attributeNames = matchingTemplates[i].getTemplateAttributeNames();%>
        <div class="attributes">
            <% for (int j = 0; j < attributeNames.length; j++) {%>
            <div class="attribute">
                <div class="attributeName"><%= attributeNames[j]%></div>
                <div class="attributeValues">
                    <% String[] attributeValues = matchingTemplates[i].getTemplateAttributeValues(attributeNames[j]);%>
                    <% for (int k = 0; k < attributeValues.length && k < 5; k++) {%>
                    <div class="attributeValue"><%= CatalogSearch.replaceAll(combinedPattern, attributeValues[k])%></div>
                    <% }%>
                </div>
            </div>
            <% }%>
        </div>
    </div>
    <% }%>
</div>
<%
}
%>