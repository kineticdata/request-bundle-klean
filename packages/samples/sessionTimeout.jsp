<%-- Set the page content type, ensuring that UTF-8 encoding is used. --%>
<%@page contentType="text/html; charset=UTF-8"%>

<%-- Initialize the bundle and load any necessary dependencies. --%>
<%@include file="framework/includes/packageInitialization.jspf"%>

<%-- Specify the HTML5 Doctype --%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sample: Session Timeout</title>

        <!-- Dependencies -->
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/event/event-min.js"></script>
        <script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/connection/connection-min.js"></script>

        <script type="text/javascript">
            // Initialize a variable representing that the user is not currently
            // authenticated.  This is used strictly to simplify the example, in
            // a real world scenario, the callback JSP would detect that the
            // user session did not have an authenticate user.
            var authenticated = true;

            // Define a sample asynchronous callback function
            function sendRequest() {
                // Define a reference to the messages element for use with the
                // sample javascript.  This div contains a "log" of requests.
                var messages = document.getElementById("messages");

                // Specify the source URL for the request.  This example uses 
                // the core generic callback JSP (and passes a parameter
                // indicating whether the response should simulate a HTTP (200)
                // OK or a HTTP (401) UNAUTHORIZED response.
                var sUrl = "<%=bundle.bundlePath()%>core/interface/callbacks/callback.jsp";
                if (authenticated) {sUrl += '?status=200';}
                else {sUrl += '?status=401'}
                
                // Define the javascript callback option.  This sample uses the
                // YUI conventions for initializing a asychronous request, but
                // most Javascript libraries will require similiar code.
                var callback = {
                    // The function to call on a successful response
                    success: function(response) {
                        // Add the response message to the messages div
                        messages.innerHTML += '<div>('+response.status+') '+response.statusText+'</div>';
                    },
                    // The function to call on a failure response
                    failure: function(response) {
                        // Add the response message to the messages div
                        messages.innerHTML += '<div>('+response.status+') '+response.statusText+'</div>';

                        // Simulate an authentication (this is where the custom
                        // re-authenticate code would go).
                        authenticated = true;

                        // Add a message that the asynchronous callback is being retried
                        messages.innerHTML += '<div>Retrying...</div>';

                        // Retry the original asynchronous callback function
                        sendRequest();
                    }
                }
                
                // Make the asynchronous callback request
                YAHOO.util.Connect.asyncRequest('GET', sUrl, callback, null);
            }

            function timeout() {
                if (authenticated) {
                    // Define a reference to the messages element for use with
                    // the sample javascript.  This div contains a "log" of
                    // requests.
                    var messages = document.getElementById("messages");

                    // Simulate deauthentication
                    authenticated=false;
                    // Add a message that the asynchronous callback is being retried
                    messages.innerHTML += '<div>Simulating Session Timeout...</div>';
                }
            }
        </script>
    </head>
    <body>
        <div class="title">Sample: Session Timeout</div>

        <div class="sample">
            <a href="javascript:void(0)" onclick="timeout();">Simulate Session Timeout</a>
        </div>
        <div class="sample">
            <a href="javascript:void(0)" onclick="sendRequest(this.authenticated)">Send Request</a>
        </div>

        <div id="messages"><div>Logged In</div></div>
    </body>
</html>