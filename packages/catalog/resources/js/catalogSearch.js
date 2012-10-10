jQuery(document).ready(function() {
    // Submit event for catalog search
    jQuery('#catalogSearchForm').submit(function(event) {
        // Prevent default action.
        event.preventDefault();
        // Execute the ajax request.
        BUNDLE.ajax({
            cache: false,
            type: jQuery(this).attr('method'),
            data: jQuery(this).serialize(),
            url: jQuery(this).attr('action'),
            beforeSend: function(jqXHR, settings) {
                before(jqXHR, settings);
            },
            success: function(data) {
                success(data);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                error(jqXHR, textStatus, errorThrown);
            }
        });
    });
    
    /**
     * Action functions for catalog search
     */
    function before(jqXHR, settings) {
       // Retrieve the search value from the search input
       var searchValue = jQuery('#searchInput').val();
       jQuery('.searchValue').text(searchValue);
       jQuery('#catalogContainer').hide();
       jQuery('#submissionsTable').hide();
       jQuery('#searchResults').hide();
       jQuery('#searchSpinner').show();
       jQuery('#homeActive').hide();
       jQuery('#homeInactive').show();
       jQuery('#divider').show();
       jQuery('#searchActive').show();
    }

    function success(data) {
       if(data) {
           jQuery('#searchSpinner').hide();
           jQuery('#searchResults').html(data).show();
       }   
    }

    function error(jqXHR, textStatus, errorThrown) {
       jQuery('#searchSpinner').hide();
       jQuery('#searchResults').html('<div class="message">There was an error. Try again.</div>').show();
    }
});