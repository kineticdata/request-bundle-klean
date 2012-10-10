<%-- Set the page content type, ensuring that UTF-8 is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Include the package initialization file. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title><%= bundle.getProperty("catalogName")%></title>

        <%-- Include the common content. --%>
        <%@include file="../../common/interface/fragments/headContent.jspf"%>

        <!-- Page Stylesheets -->
        <link rel="stylesheet" href="<%= bundle.packagePath()%>resources/css/submissions.css" type="text/css" />
        <!-- Page Javascript -->
        <script type="text/javascript" src="<%=bundle.bundlePath()%>common/resources/js/arsTable.js"></script>
        <script type="text/javascript" src="<%=bundle.packagePath()%>resources/js/submissions.js"></script>
    </head>

    <body>
        <div id="bodyContainer">
            <%@include file="../../common/interface/fragments/contentHeader.jspf"%>
            <div id="contentBody">
                <div class="navigation">
                    <div data-type="Requests" class="navigationItem active">Requests</div>
                    <div data-type="Approvals" class="navigationItem">Approvals</div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>

                <div class="content">
                    <div class="switches" id="switchesRequests">
                        <div data-type="Requests" data-subtype="Open" class="switch active">Open</div>
                        <div data-type="Requests" data-subtype="Closed" class="switch">Closed</div>
                        <div data-type="Requests" data-subtype="Parked" class="switch">Parked</div>
                        <div class="clear"></div>
                    </div>
                    <div class="switches hidden" id="switchesApprovals">
                        <div data-type="Approvals" data-subtype="Pending" class="switch active">Pending</div>
                        <div data-type="Approvals" data-subtype="Completed" class="switch">Completed</div>
                        <div class="clear"></div>
                    </div>
                    <%@include file="interface/fragments/tableControls.jspf"%>
                    <div class="tableContainer hidden" id="tableContainerRequestsOpen"></div>
                    <div class="tableContainer hidden" id="tableContainerRequestsClosed"></div>
                    <div class="tableContainer hidden" id="tableContainerRequestsParked"></div>
                    <div class="tableContainer hidden" id="tableContainerApprovalsPending"></div>
                    <div class="tableContainer hidden" id="tableContainerApprovalsCompleted"></div>
                    <%@include file="interface/fragments/tableControls.jspf"%>
                </div>

                <div class="contentFooter"></div>
            </div>
            <%@include file="../../common/interface/fragments/contentFooter.jspf"%>
        </div>
    </body>
</html>