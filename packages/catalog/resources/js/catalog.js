jQuery(document).ready(function() {    
    jQuery('#homeInactive').hide();
    jQuery('#divider').hide();
    jQuery('#searchActive').hide();
    
    jQuery('#homeInactive a').click(function() {
        jQuery('#homeInactive').hide();
        jQuery('#searchActive').hide();
        jQuery('#divider').hide();
        jQuery('#searchResults').hide();
        jQuery('#homeActive').show();
        jQuery('#catalogContainer').show();
    });
});