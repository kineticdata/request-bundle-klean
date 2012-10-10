<%-- Set the page content type, ensuring that UTF-8 encoding is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Initialize the bundle and load any necessary dependencies. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%-- Specify the HTML5 Doctype --%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Bundle Info</title>
    </head>
    <body>
        <div>Paths</div>
        <div><b>Application Path:</b> <%= bundle.applicationPath() %></div>
        <div><b>Bundle Path:</b> <%= bundle.bundlePath() %></div>
        <div><b>Package Path:</b> <%= bundle.packagePath() %></div>
        <div><b>Relative Bundle Path:</b> <%= bundle.relativeBundlePath() %></div>
        <div><b>Relative Package Path:</b> <%= bundle.relativePackagePath() %></div>
        <br/>
        <div>Configuration Properties</div>
        <% for (String name : bundle.propertyKeys()) { %>
        <div><b><%= name %>:</b> <%= bundle.getProperty(name) %></div>
        <% } %>
    </body>
</html>