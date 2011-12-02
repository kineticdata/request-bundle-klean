<%-- 
    This file is used as a very simple troubleshooting callback that responds 
    with an HTTP (401) Unauthorized response.  This response mimics the behavior
    that most callbacks will exibit when a callback request is made and the user
    is not logged in or has had a session timeout.
--%>
<%@include file="../../framework/helpers/ResponseHelper.jspf"%>
<% ResponseHelper.sendUnauthorizedResponse(response); %>