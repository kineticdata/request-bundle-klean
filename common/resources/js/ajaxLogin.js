/*
 * This function essentially wraps the jQuery.ajax() function as to provide
 * support for an ajax login.  It works by adding a special callback handler
 * (defined below) that is called when the ajax call returns a 401 status code.
 * After adding the callback handler it simply calls the jQuery.ajax() function
 * with the options it was passed.
 */
BUNDLE.ajax = function(options) {
    if ( options['statusCode'] == undefined ) {
        options['statusCode'] = {};
    }
    if ( options['statusCode'][401] == undefined ) {
        options['statusCode'][401] = function() {
            BUNDLE.ajaxLogin(options);
        }
    }
    jQuery.ajax(options);
}

/*
 * This function is meant to be a callback handler for an ajax call that returns
 * a 401 status code.  It creates and displays a login dialog.  When the user
 * fills out the login form it sends a post to the kinetic authentication
 * servlet.  If the authentication is successful it will attempt the original
 * call, if not it will display the login dialog again.
 */
BUNDLE.ajaxLogin = function(options) {
    var html = '<div id="ajaxLogin" title="Please Login">';
    html += '<form id="ajaxLoginForm" name="Login" action="KSAuthenticationServlet">';
    html += '<div class="field">';
    html += '<div class="label"><label for="UserName">User:</label></div>';
    html += '<div class="input"><input id="UserName" name="UserName" type="text" autocomplete="off" ></div>';
    html += '<div class="clear"></div>'
    html += '</div>'
    html += '<div class="field">';
    html += '<div class="label"><label for="Password">Password:</label></div>';
    html += '<div class="input"><input id="Password" name="Password" type="password" autocomplete="off" ></div>';
    html += '<div class="clear"></div>'
    html += '</div>';
    html += '<input name="originatingPage" type="hidden">';
    html += '</form>';
    html += '</div>';
    var element = jQuery(html);
    jQuery('#bodyContainer').append(element);
    element.dialog({
        closeText: 'cancel',
        width: 300,
        modal: true,
        buttons : {
            "Log In": function() {
                var data = jQuery('#ajaxLoginForm').serialize();
                element.dialog('close');
                element.remove();
                jQuery.ajax({
                    type: "POST",
                    url: "KSAuthenticationServlet",
                    data: data,
                    success: function() { BUNDLE.ajax(options); },
                    error: function() { BUNDLE.ajaxLogin(options); }
                });
            }
        }
    });
    $(element).parent().append('<div class="kd-shadow"></div>');
}