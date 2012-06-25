/*
 * On document ready we will load the tables present on the page and bind events
 * that handle the navigation tabs as well as the table controls.
 */
jQuery(document).ready(function() {
    /*
     * Define the common table options that all of the tables on this page will
     * share.  Here we define the form the tables represent, the fields present,
     * the default sort field and order, the default page size and number, as
     * well as the entire table callback and the header callback.
     */
    var tableOptions = {
        form: "KS_SRV_CustomerSurvey_base",
        fields: {
            'Request Id'   : '1',
            'Submitted'    : '700001285',
            'Service Item' : '700001000',
            'Status'       : '700002400',
            'First Name'   : '300299800',
            'Last Name'    : '700001806'
        },
        hiddenFields: {
            'Instance Id' : '179'
        },
        sortField: "Request Id",
        sortOrder: "descending",
        pageSize: 15,
        pageNumber: 1,
        // This callback function simply refreshes the table controls by calling
        // the refreshTableControls function defined below.
        tableCallback: function(table, element) {
            refreshTableControls();
        },
        // This callback function binds a click event to each of the header
        // cells that when clicked it either sorts the table by that field or
        // toggles the sort order depending on if it was already sorting by that
        // field.
        headerCallback: function(table, element, label) {
            jQuery(element).click(function() {
                if ( label != table.sortField ) {
                    table.sortBy(label);
                } else {
                    table.toggleSort();
                }
            });
        }
    }
    
    /*
     * Define the cell callback function for the open and closed requests table.
     * If the cell is displaying a request id instead of the normal text we will
     * create a link that triggers a dialog displaying submission details.
     */
    function requestsOpenClosedCellCallback(table, element, rowData, rowIndex, cellData, cellIndex) {
        if ( cellIndex == table.getIndex('Request Id') ) {
            jQuery(element).empty();
            var anchor = jQuery('<a href="javascript:void(0)">' + cellData + '</a>');
            anchor.click(function() {
                BUNDLE.ajax({
                    url: BUNDLE.packagePath + 'interface/callbacks/submissionDetails.html.jsp?csrv=' + rowData[table.getIndex('Instance Id')],
                    success: function(data) {
                        var element = jQuery(data);
                        jQuery('#dialogContainer').append(element);
                        element.dialog({
                            closeText: 'close',
                            width: 500
                        });
                        $(element).parent().append('<div class="kd-shadow"></div>');
                    }
                });
            });
            jQuery(element).append(anchor);
        }
    }
    
    /*
     * Define the cell callback for the parked requests table.  This function
     * inserts a link that takes the user to the parked request.
     */
    function requestsParkedCellCallback(table, element, rowData, rowIndex, cellData, cellIndex) {
        if ( cellIndex == table.getIndex('Request Id') ) {
            jQuery(element).empty();
            var anchor = jQuery('<a href="javascript:void(0)">' + cellData + '</a>');
            anchor.attr('href', '/kinetic/DisplayPage?csrv=' + rowData[table.getIndex('Instance Id')] + '&return=yes');
            anchor.attr('target', '_blank');
            jQuery(element).append(anchor);
        }
    }
    
    /*
     * Define the cell callback for the pending approvals table.  This function
     * inserts a link that takes the user to the approval.
     */
    function approvalsPendingCellCallback(table, element, rowData, rowIndex, cellData, cellIndex) {
        if ( cellIndex == table.getIndex('Request Id') ) {
            jQuery(element).empty();
            var anchor = jQuery('<a href="javascript:void(0)">' + cellData + '</a>');
            anchor.attr('href', '/kinetic/DisplayPage?csrv=' + rowData[table.getIndex('Instance Id')]);
            anchor.attr('target', '_blank');
            jQuery(element).append(anchor);
        }
    }
    
    /*
     * Instantiate all of the tables and store them in an object that maps a
     * name to each table.
     */
    var tables = {
        RequestsOpen: new Table(jQuery.extend(tableOptions, {
            container: '#tableContainerRequestsOpen',
            qualification: 'RequestsOpen',
            cellCallback: requestsOpenClosedCellCallback
        })),
        RequestsClosed: new Table(jQuery.extend(tableOptions, {
            container: '#tableContainerRequestsClosed',
            qualification: 'RequestsClosed',
            cellCallback: requestsOpenClosedCellCallback
        })),
        RequestsParked: new Table(jQuery.extend(tableOptions, {
            container: '#tableContainerRequestsParked',
            qualification: 'RequestsParked',
            cellCallback: requestsParkedCellCallback
        })),
        ApprovalsPending: new Table(jQuery.extend(tableOptions, {
            container: '#tableContainerApprovalsPending',
            qualification: 'ApprovalsPending',
            cellCallback: approvalsPendingCellCallback
        })),
        ApprovalsCompleted: new Table(jQuery.extend(tableOptions, {
            container: '#tableContainerApprovalsCompleted',
            qualification: 'ApprovalsCompleted'
        }))
    }
    
    /*
     * Determine the active table and create a variable that points to it.  This
     * variable will be referenced by the control functions so we can have one
     * set of controls for all of the tables.
     */
    var activeTable = tables["RequestsOpen"];
    /*
     * Set the default active states.  This information is used when switching
     * between submission types to determine which subtype was last selected.
     */
    var states = {
        'Requests'  : 'Open',
        'Approvals' : 'Pending'
    }
    /*
     * Show the active table.
     */
    jQuery(activeTable.container).show();

    /*
     * Bind a function to each of the navigation items for the submission types.
     * This function should handle adding/removing of the "active" class as well
     * as hiding/showing the proper subtype options.  Finally it should handle
     * showing the proper active table as well as refreshing the table controls.
     */
    jQuery(".navigation .navigationItem").click(function() {
        jQuery(this).siblings().removeClass("active");
        jQuery(this).addClass("active");
        jQuery(".switches").hide();
        jQuery(".switches#switches" + jQuery(this).data("type")).show();
        jQuery(".tableContainer").hide();
        jQuery(".tableContainer#tableContainer" + jQuery(this).data("type") + states[jQuery(this).data("type")]).show();
        activeTable = tables[jQuery(this).data("type") + states[jQuery(this).data("type")]];
        refreshTableControls();
    });
    
    /*
     * Bind a function to each of the switches for the submission subtypes.  It
     * should handle adding/removing the "active" class as well as showing the
     * proper active table and refreshing the table controls.
     */
    jQuery(".switches .switch").click(function() {
        jQuery(this).siblings().removeClass("active");
        jQuery(this).addClass("active");
        jQuery(".tableContainer").hide();
        jQuery(".tableContainer#tableContainer" + jQuery(this).data("type") + jQuery(this).data("subtype")).show();
        states[jQuery(this).data("type")] = jQuery(this).data("subtype");
        activeTable = tables[jQuery(this).data("type") + jQuery(this).data("subtype")];
        refreshTableControls();
    });
    
    /*
     * Create a function that refreshes details displayed in the table controls.
     */
    function refreshTableControls() {
        jQuery('.controls .pageNumber .currentPage').val(activeTable.pageNumber);
        jQuery('.controls .pageNumber .lastPage').html(activeTable.lastPageNumber);
        jQuery('.controls .pageNumber .recordCount').html(activeTable.count);
        jQuery('.controls .pageSize select option[selected="selected"]').removeAttr('selected');
        jQuery('.controls .pageSize select option[value="'+ activeTable.pageSize + '"]').attr("selected", "selected");
    }
    
    /*
     * Bind functions to the table controls dom elements.
     */
    jQuery('.controls .control.firstPage').click(function() {
        activeTable.firstPage();
    });
    jQuery('.controls .control.previousPage').click(function() {
        activeTable.previousPage();
    });
    jQuery('.controls .control.nextPage').click(function() {
        activeTable.nextPage();
    });
    jQuery('.controls .control.lastPage').click(function() {
        activeTable.lastPage();
    });
    jQuery('.controls .pageSize select').change(function() {
        activeTable.setPageSize(parseInt($(this).val()));
    });
    jQuery('.controls .pageNumber input').change(function() {
        if( isNaN(parseInt($(this).val())) ) {
            $(this).val('');
        } else {
            activeTable.gotoPage($(this).val());
        }
    });
    jQuery('.controls .control.refresh').click(function() {
        activeTable.refresh();
    });
    
});