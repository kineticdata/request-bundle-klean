jQuery(document).ready(function() {
    var catalogSearch = new CatalogSearch({
        catalogName: BUNDLE.config['catalogName'],
        searchButton: '#searchButton',
        searchInput: '#searchInput',
        searchResultsContainer: '#searchResults',
        searchBeginCallback : function(catalogName, searchValue) {
            jQuery('.searchValue').text(searchValue);
            jQuery('#catalogContainer').hide();
            jQuery('#searchResults').hide();
            jQuery('#searchSpinner').show();
            jQuery('#homeActive').hide();
            jQuery('#homeInactive').show();
            jQuery('#divider').show();
            jQuery('#searchActive').show();
        },
        searchEndCallback : function(catalogName, searchValue) {
            jQuery('#searchSpinner').hide();
            jQuery('#searchResults').show();
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