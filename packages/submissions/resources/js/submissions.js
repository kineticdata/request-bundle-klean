jQuery(document).ready(function() {
    var state = {
        'activeSubmissionType'    : 'Requests',
        'activeSubmissionSubtype' : {
            'Requests'  : 'Open',
            'Approvals' : 'Pending'
        }
    }
    
    function getActiveTable() {
        var activeType = state['activeSubmissionType'];
        var activeSubtype = state['activeSubmissionSubtype'][state['activeSubmissionType']];
        return tables[activeType + activeSubtype];
    }
    
    /*
     * Here we activate the submissions type tab.
     */
    var navigationItems = jQuery('.navigation .navigationItem');
    var contentItems = jQuery('.content .switches');
    navigationItems.click(function() {
        state['activeSubmissionType'] = jQuery(this).text();
        jQuery(this).siblings().removeClass('active');
        jQuery(this).addClass('active');
        contentItems.addClass('hidden');
        jQuery(contentItems[navigationItems.index(this)]).removeClass('hidden');
        jQuery('.tableContainer').hide();
        jQuery(getActiveTable().container).show();
        jQuery('.controls .pageNumber .currentPage').val(getActiveTable().pageNumber);
        jQuery('.controls .pageNumber .lastPage').html(getActiveTable().lastPageNumber);
        jQuery('.controls .pageNumber .recordCount').html(getActiveTable().count);
        jQuery('.controls .pageSize select option[selected="selected"]').removeAttr('selected');
        jQuery('.controls .pageSize select option[value="'+ getActiveTable().pageSize + '"]').attr("selected", "selected");
    });
    
    /*
     * Here we activate the submission type switches.
     */
    jQuery('.switches .switch').click(function() {
        state['activeSubmissionSubtype'][state['activeSubmissionType']] = jQuery(this).text();
        jQuery(this).siblings().removeClass('active');
        jQuery(this).addClass('active');
        jQuery('.tableContainer').hide();
        jQuery(getActiveTable().container).show();
        jQuery('.controls .pageNumber .currentPage').val(getActiveTable().pageNumber);
        jQuery('.controls .pageNumber .lastPage').html(getActiveTable().lastPageNumber);
        jQuery('.controls .pageNumber .recordCount').html(getActiveTable().count);
        jQuery('.controls .pageSize select option[selected="selected"]').removeAttr('selected');
        jQuery('.controls .pageSize select option[value="'+ getActiveTable().pageSize + '"]').attr("selected", "selected");
    });
    
    /*
     * Bind functions to the request table control elements.
     */
    jQuery('.controls .control.firstPage').click(function() {
        getActiveTable().firstPage();
    });
    jQuery('.controls .control.previousPage').click(function() {
        getActiveTable().previousPage();
    });
    jQuery('.controls .control.nextPage').click(function() {
        getActiveTable().nextPage();
    });
    jQuery('.controls .control.lastPage').click(function() {
        getActiveTable().lastPage();
    });
    jQuery('.controls .pageSize select').change(function() {
        getActiveTable().setPageSize(parseInt($(this).val()));
    });
    jQuery('.controls .pageNumber input').change(function() {
        if( isNaN(parseInt($(this).val())) ) {
            $(this).val('');
        } else {
            getActiveTable().gotoPage($(this).val());
        }
    });
    jQuery('.controls .control.refresh').click(function() {
        getActiveTable().refresh();
    });
    
    var submissionsForm = 'KS_SRV_CustomerSurvey_base';
    var submissionsFields = {
        'Request Id'   : '1',
        'Submitted'    : '700001285',
        'Service Item' : '700001000',
        'Status'       : '700002400',
        'First Name'   : '300299800',
        'Last Name'    : '700001806'
    }
    var submissionsHiddenFields = {
        'Instance Id' : '179'
    }
    var submissionsSortField = 'Request Id';
    var submissionsSortOrder = 'descending';
    var submissionsPageSize = 15;
    var submissionsPageNumber = 1;

    function commonTableCallback(table, element) {
        jQuery('.controls .pageNumber .currentPage').val(table.pageNumber);
        jQuery('.controls .pageNumber .lastPage').html(table.lastPageNumber);
        jQuery('.controls .pageNumber .recordCount').html(table.count);
        jQuery('.controls .pageSize select option[selected="selected"]').removeAttr('selected');
        jQuery('.controls .pageSize select option[value="'+ table.pageSize + '"]').attr("selected", "selected");
    }
    
    function commonHeaderCallback(table, element, label) {
        jQuery(element).click(function() {
            if ( label != table.sortField ) {
                table.sortBy(label);
            } else {
                table.toggleSort();
            }
        });
    }
    
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
    
    function requestsParkedCellCallback(table, element, rowData, rowIndex, cellData, cellIndex) {
        if ( cellIndex == table.getIndex('Request Id') ) {
            jQuery(element).empty();
            var anchor = jQuery('<a href="javascript:void(0)">' + cellData + '</a>');
            anchor.attr('href', '/kinetic/DisplayPage?csrv=' + rowData[table.getIndex('Instance Id')] + '&return=yes');
            anchor.attr('target', '_blank');
            jQuery(element).append(anchor);
        }
    }
    
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
     * Instantiate a hash that stores the table objects indexed by their name.
     */
    var tables = {};
    /*
     * Instantiate the tables that will be displayed on the submissions page.
     */
    tables['RequestsOpen'] = new Table({
        container: '#tableContainerRequestsOpen',
        form: submissionsForm,
        qualification: 'RequestsOpen',
        fields: submissionsFields,
        hiddenFields: submissionsHiddenFields,
        sortField: submissionsSortField,
        sortOrder: submissionsSortOrder,
        pageSize: submissionsPageSize,
        pageNumber: submissionsPageNumber,
        tableCallback: commonTableCallback,
        headerCallback: commonHeaderCallback,
        cellCallback: requestsOpenClosedCellCallback
    });
    
    tables['RequestsClosed'] = new Table({
        container: '#tableContainerRequestsClosed',
        form: submissionsForm,
        qualification: 'RequestsClosed',
        fields: submissionsFields,
        hiddenFields: submissionsHiddenFields,
        sortField: submissionsSortField,
        sortOrder: submissionsSortOrder,
        pageSize: submissionsPageSize,
        pageNumber: submissionsPageNumber,
        tableCallback: commonTableCallback,
        headerCallback: commonHeaderCallback,
        cellCallback: requestsOpenClosedCellCallback
    });
    
    tables['RequestsParked'] = new Table({
        container: '#tableContainerRequestsParked',
        form: submissionsForm,
        qualification: 'RequestsParked',
        fields: submissionsFields,
        hiddenFields: submissionsHiddenFields,
        sortField: submissionsSortField,
        sortOrder: submissionsSortOrder,
        pageSize: submissionsPageSize,
        pageNumber: submissionsPageNumber,
        tableCallback: commonTableCallback,
        headerCallback: commonHeaderCallback,
        cellCallback: requestsParkedCellCallback
    });
    
    tables['ApprovalsPending'] = new Table({
        container: '#tableContainerApprovalsPending',
        form: submissionsForm,
        qualification: 'ApprovalsPending',
        fields: submissionsFields,
        hiddenFields: submissionsHiddenFields,
        sortField: submissionsSortField,
        sortOrder: submissionsSortOrder,
        pageSize: submissionsPageSize,
        pageNumber: submissionsPageNumber,
        tableCallback: commonTableCallback,
        headerCallback: commonHeaderCallback,
        cellCallback: approvalsPendingCellCallback
    });
    
    tables['ApprovalsCompleted'] = new Table({
        container: '#tableContainerApprovalsComplete',
        form: submissionsForm,
        qualification: 'ApprovalsCompleted',
        fields: submissionsFields,
        hiddenFields: submissionsHiddenFields,
        sortField: submissionsSortField,
        sortOrder: submissionsSortOrder,
        pageSize: submissionsPageSize,
        pageNumber: submissionsPageNumber,
        tableCallback: commonTableCallback,
        headerCallback: commonHeaderCallback
    });
    
    jQuery(getActiveTable().container).show();
});