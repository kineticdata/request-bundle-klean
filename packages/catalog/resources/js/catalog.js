jQuery(document).ready(function() {
    var catalogSearch = new CatalogSearch({
        catalogName: BUNDLE.config['catalogName'],
        searchButton: '#searchButton',
        searchInput: '#searchInput',
        searchResultsContainer: '#searchResults',
        searchBeginCallback : function(catalogName, searchValue) {
            jQuery('#catalogContainer').hide();
            jQuery('#searchResults').hide();
            jQuery('#searchSpinner').show();
            
        },
        searchEndCallback : function(catalogName, searchValue) {
            jQuery('#searchSpinner').hide();
            jQuery('#searchResults').show();
            jQuery('#homeActive').hide();
            jQuery('#homeInactive').show();
            jQuery('#divider').show();
            jQuery('#searchValue').text(searchValue);
            jQuery('#searchActive').show();
        }
    });
    
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