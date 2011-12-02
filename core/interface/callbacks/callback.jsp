<%--
    TODO: Redesign to be a "generic" callback for developing and troubleshooting
        asynchronous requests.

    This file is used as a very simple troubleshooting callback that responds 
    with an HTTP (401) Unauthorized response.  This response mimics the behavior
    that most callbacks will exibit when a callback request is made and the user
    is not logged in or has had a session timeout.
--%>
<%@include file="../../framework/helpers/ResponseHelper.jspf"%>
<% 
    if ("200".equals(request.getParameter("status"))) {
        ResponseHelper.sendOkResponse(response); 
    } else if ("401".equals(request.getParameter("status"))) {
        ResponseHelper.sendUnauthorizedResponse(response);
    }
%>