var __bind = function(fn, me) {
    return function() {
        return fn.apply(me, arguments); 
    };
};

function CatalogSearch(options) {
    /*
     * Store the options passed to this 'constructor' as 'instance' variables of
     * the object.
     */
    this.searchButton = options['searchButton'];
    this.searchInput = options['searchInput'];
    this.searchResultsContainer = options['searchResultsContainer'];
    this.searchBeginCallback = options['searchBeginCallback'];
    this.searchEndCallback = options['searchEndCallback'];
    
    /*
     * Bind a click event to the search button that calls the search function.
     */
    jQuery(this.searchButton).click(__bind(function() {
        this.search();
    }, this));
    
    /*
     * Bind a keyup event (that only acts if they key pressed was 'enter') that
     * calls the search function.
     */
    jQuery(this.searchInput).keyup(__bind(function(event){
        if(event.keyCode == '13') {
            this.search();
        }
    }, this));
}

CatalogSearch.prototype.search = function() {
    var catalogName = BUNDLE.config['catalogName'];
    var searchValue = jQuery(this.searchInput).val();
    if (this.searchBeginCallback != undefined) {
        this.searchBeginCallback();
    }
    jQuery.ajax({
        url: BUNDLE.bundlePath + 'libraries/catalogSearch/catalogSearch.html.jsp?catalogName=' + catalogName + '&query=' + searchValue,
        success: __bind(function(data) {
            if (this.searchEndCallback != undefined) {
                this.searchEndCallback();
            }
            jQuery(this.searchInput).val('');
            jQuery(this.searchResultsContainer).empty();
            jQuery(this.searchResultsContainer).append(data);
        }, this),
        failure: function(data) {
            alert('failure: ' + data);
        }
    });
};
