<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../../framework/includes/packageInitialization.jspf"%>
<%
    if (context == null) {
        ResponseHelper.sendUnauthorizedResponse(response);
    } else {
        String csrv = request.getParameter("csrv");
        Submission submission = Submission.findByInstanceId(context, csrv);

        if (submission == null) {
%>
<div class="submissionDetails">
    Unable to locate record
</div>
<%} else {
%>
<div class="submissionDetails" title="Submission Details">
    <div class="header">
        <div class="requestId">
            <a href="/kinetic/ReviewRequest?csrv=<%=submission.getId()%>&reviewPage=<%= bundle.getProperty("reviewJsp")%>">
                <%= submission.getRequestId()%>
            </a>
        </div>
        <div class="serviceItem"><%= submission.getTemplateName()%></div>
        <div class="close"></div>
        <div class="clear"></div>
    </div>
    <div class="info">
        <div class="label">Status</div>
        <div class="value"><%= submission.getValiationStatus()%></div>
        <div class="clear"></div>
        <div class="label">Initiated</div>
        <div class="value"><%= DateHelper.formatDate(submission.getCreateDate(), request.getLocale())%></div>
        <div class="clear"></div>
        <% if (submission.getRequestStatus().equals("Closed")) {%>
        <div class="label">Completed</div>
        <div class="value"><%= DateHelper.formatDate(submission.getRequestClosedDate(), request.getLocale())%></div>
        <div class="clear"></div>
        <%}%>
        <div class="label">Notes</div>
        <div class="value"><%= submission.getNotes()%></div>
        <div class="clear"></div>
    </div>

    <div class="tasks">
        <% CycleHelper zebraCycle = new CycleHelper(new String[]{"odd", "even"});%>
        <% for (String treeName : submission.getTaskTreeExecutions(context).keySet()) {%>
        <% for (Task task : submission.getTaskTreeExecutions(context).get(treeName)) {%>
        <div class="task <%= zebraCycle.cycle()%>">
            <div class="label">Task</div>
            <div class="value"><%= task.getName()%></div>
            <div class="clear"></div>
            <div class="label">Status</div>
            <div class="value"><%= task.getStatus()%></div>
            <div class="clear"></div>
            <div class="label">Initiated</div>
            <div class="value"><%= DateHelper.formatDate(task.getCreateDate(), request.getLocale())%></div>
            <div class="clear"></div>
            <% if (task.getStatus().equals("Closed")) {%>
            <div class="label">Completed</div>
            <div class="value"><%= DateHelper.formatDate(task.getModifiedDate(), request.getLocale())%></div>
            <div class="clear"></div>
            <%}%>
            <div class="label">Messages</div>
            <div class="value">
                <% for (TaskMessage message : task.getMessages(context)) {%>
                <div class="message"><%= message.getMessage()%></div>
                <% }%>
            </div>
            <div class="clear"></div>
        </div>
        <% }%>
        <% }%>
    </div>
    <div style="height: 1px;"></div>
</div>
<% }%>
<% }%>