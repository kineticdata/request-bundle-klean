<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<!DOCTYPE html>

<html>
    <head>
        <title><%= bundle.getProperty("catalogName")%></title>

        <%-- Include the common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/submissions.css" type="text/css">

        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.bundlePath()%>libraries/jQuery/jquery-1.7.1.js"></script>
        <script type="text/javascript" src="<%=bundle.bundlePath()%>libraries/jQuery/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="<%=bundle.bundlePath()%>libraries/arsTable/arsTable.js"></script>
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/submissions.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>
            <div id="contentBody">
                <div class="navigation">
                    <div class="navigationItem active">Requests</div>
                    <div class="navigationItem">Approvals</div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>

                <div class="content">
                    <div class="switches" id="switchesRequests">
                        <div class="switch active">Open</div>
                        <div class="switch">Closed</div>
                        <div class="switch">Parked</div>
                        <div class="clear"></div>
                    </div>
                    <div class="switches hidden" id="switchesApprovals">
                        <div class="switch active">Pending</div>
                        <div class="switch">Completed</div>
                        <div class="clear"></div>
                    </div>
                    <%@include file="interface/fragments/tableControls.jspf"%>
                    <div class="tableContainer hidden" id="tableContainerRequestsOpen"></div>
                    <div class="tableContainer hidden" id="tableContainerRequestsClosed"></div>
                    <div class="tableContainer hidden" id="tableContainerRequestsParked"></div>
                    <div class="tableContainer hidden" id="tableContainerApprovalsPending"></div>
                    <div class="tableContainer hidden" id="tableContainerApprovalsComplete"></div>
                    <%@include file="interface/fragments/tableControls.jspf"%>
                </div>

                <div class="contentFooter"></div>
            </div>
            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html>