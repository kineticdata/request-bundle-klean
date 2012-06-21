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
    this.catalogName = options['catalogName'];
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
    // Build a timestamp variable to be passed as a noCache parameter on the ajax
    // request to ensure that browsers do not cache these requests.
    var date = new Date();
    var timestamp = date.getTime();
    
    // Retrieve the search value from the search input
    this.searchValue = jQuery(this.searchInput).val();
    
    // Trigger the search begin callback.  We pass the callback the catalog name
    // and the search value paramters
    if (this.searchBeginCallback != undefined) {
        this.searchBeginCallback(this.catalogName, this.searchValue);
    }
    
    // Execute the ajax request.
    BUNDLE.ajax({
        url: BUNDLE.packagePath + 'interface/callbacks/catalogSearch.html.jsp?catalogName=' + this.catalogName + '&query=' + this.searchValue + '&noCache=' + timestamp,
        success: __bind(function(data) {
            jQuery(this.searchInput).val('');
            jQuery(this.searchResultsContainer).empty();
            jQuery(this.searchResultsContainer).append(data);
            if (this.searchEndCallback != undefined) {
                this.searchEndCallback(this.catalogName, this.searchValue);
            }
        }, this)
    });
};
