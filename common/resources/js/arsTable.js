var __bind = function(fn, me) {
    return function() {
        return fn.apply(me, arguments); 
    };
};

function Table(options) {
    this.container = options['container'];
    this.form = options['form'];
    this.qualification = options['qualification'];
    this.fields = options['fields'];
    this.hiddenFields = options['hiddenFields'];
    this.sortField = options['sortField'];
    this.sortOrder = options['sortOrder'];
    this.pageSize = options['pageSize'];
    this.pageNumber = options['pageNumber'];
    this.tableCallback = options['tableCallback'];
    this.headerCallback = options['headerCallback'];
    this.rowCallback = options['rowCallback'];
    this.cellCallback = options['cellCallback'];
    this.refresh();
}

Table.prototype.getIndex = function(field) {
    var i = 0;
    for ( var curField in this.fields ) {
        if ( this.fields.hasOwnProperty(curField) ) {
            if ( curField == field ) {
                return i;
            }
            i++;
        }
    }
    for ( var curField in this.hiddenFields ) {
        if ( this.hiddenFields.hasOwnProperty(curField) ) {
            if ( curField == field ) {
                return i;
            }
            i++;
        }
    }
    return undefined;
};

Table.prototype.setQualification = function(qualification) {
    this.qualification = qualification;
    this.pageNumber = 1;
    this.refresh();
};

Table.prototype.setPageSize = function(pageSize) {
    this.pageSize = pageSize;
    this.pageNumber = 1;
    this.refresh();
};

Table.prototype.sortBy = function(field) {
    this.sortField = field;
    this.sortOrder = "ascending";
    this.pageNumber = 1;
    this.refresh();
};

Table.prototype.toggleSort = function() {
    if ( this.sortOrder == "ascending" ) {
        this.sortOrder = "descending";
    } else {
        this.sortOrder = "ascending";
    }
    this.pageNumber = 1;
    this.refresh();
};

Table.prototype.firstPage = function() {
    this.pageNumber = 1;
    this.refresh();
}

Table.prototype.previousPage = function() {
    if ( this.pageNumber > 1 ) {
        this.pageNumber -= 1;
    }
    this.refresh();
}

Table.prototype.nextPage = function() {
    if ( this.pageNumber < this.lastPageNumber ) {
        this.pageNumber += 1;
    }
    this.refresh();
}
Table.prototype.lastPage = function() {
    this.pageNumber = this.lastPageNumber;
    this.refresh();
}

Table.prototype.gotoPage = function(pageNumber) {
    if ( pageNumber > this.lastPageNumber ) {
        this.pageNumber = this.lastPageNumber;   
    } else {
        this.pageNumber = pageNumber;
    }
    this.refresh();
}

Table.prototype.refresh = function() {
    var fieldIds = '';
    var index = 0;
    for ( var field in this.fields ) {
        if ( this.fields.hasOwnProperty(field) ) {
            if ( index > 0) {
                fieldIds += ',';
            }
            fieldIds += this.fields[field];
            index++;
        }
    }
    var index = 0;
    for( var field in this.hiddenFields ) {
        if ( this.hiddenFields.hasOwnProperty(field) ) {
            fieldIds += ',';
            fieldIds += this.hiddenFields[field];
            index++;
        }
    }
    
    // Build a timestamp that will be used as an argument for the noCache paramter
    var date = new Date();
    var timestamp = date.getTime();
    
    var url = BUNDLE.bundlePath + 'common/interface/callbacks/arsTable.json.jsp' +
    '?form=' + this.form +
    '&qualification=' + this.qualification +
    '&fieldIds=' + fieldIds +
    '&sortFieldId=' + this.fields[this.sortField] +
    '&sortOrder=' + this.sortOrder +
    '&pageSize=' + this.pageSize +
    '&pageNumber=' + this.pageNumber +
    '&noCache=' + timestamp;
    BUNDLE.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        success: __bind(function(data) {
            this.tableData = data.records;
            this.count = data.count;
            this.lastPageNumber = Math.ceil(this.count/this.pageSize);
            this.redraw();
        }, this)
    });
}

Table.prototype.redraw = function() {
    var table = jQuery('<table></table>');
    table.addClass('kd-table');
    var row = jQuery('<tr></tr>');
    row.addClass('kd-headerrow');
    for ( var field in this.fields ) {
        if ( this.fields.hasOwnProperty(field) ) {
            var header = jQuery('<th></th>');
            header.addClass('kd-header');
            header.text(field);
            header.hover(function() {
                jQuery(this).addClass('kd-highlight');
            }, function() {
                jQuery(this).removeClass('kd-highlight');
            });
            if (this.headerCallback != undefined) {
                this.headerCallback(this, header, field);
            }
            row.append(header);
        }
    }
    table.append(row);
    for ( var i=0; i<this.tableData.length; i++ ) {
        var row = jQuery('<tr></tr>');
        row.addClass('kd-row');
        if ( i % 2 == 0 ) {
            row.addClass('kd-odd');
        } else {
            row.addClass('kd-even');
        }
        row.hover(function() {
            jQuery(this).addClass('kd-highlight');
        }, function() {
            jQuery(this).removeClass('kd-highlight');
        });
        var j=0;
        for ( var field in this.fields ) {
            if ( this.fields.hasOwnProperty(field) ) {
                var cell = jQuery('<td></td>');
                cell.addClass('kd-cell');
                cell.hover(function() {
                    jQuery(this).addClass('kd-highlight');
                }, function() {
                    jQuery(this).removeClass('kd-highlight');
                });
                cell.text(this.tableData[i][j])

                if (this.cellCallback != undefined) {
                    this.cellCallback(this, cell, this.tableData[i], i, this.tableData[i][j], j);
                }
                row.append(cell);    
                j++;
            }
        }
        if (this.rowCallback != undefined) {
            this.rowCallback(this, row, this.tableData[i], i);
        }
        table.append(row);
    }
    if (this.tableCallback != undefined) {
        this.tableCallback(this, table);
    }
    jQuery(this.container).empty();
    jQuery(this.container).append(table);
}

//Table.prototype.redraw = function () {
//    var table = document.createElement('table');
//    var tbody = document.createElement('tbody');
//    table.setAttribute('class', 'kd-table');
//    var headerRow = document.createElement('tr');
//    headerRow.setAttribute('class', 'kd-headerrow');
//    for ( var field in this.fields ) {
//        if ( this.fields.hasOwnProperty(field) ) {
//            var header = document.createElement('th');
//            header.onmouseover = function() {
//                this.className += ' kd-highlight';
//            };
//            header.onmouseout = function() {
//                this.className = this.className.replace(/(?:^|\s)kd-highlight(?!\S)/,'');
//            }
//            header.setAttribute('class', 'kd-header');
//            var text = document.createTextNode(field);
//            header.appendChild(text);
//            this.headerCallback(this, header, field);
//            headerRow.appendChild(header);
//        }
//    }
//    tbody.appendChild(headerRow);
//    for ( var i=0; i<this.tableData.length; i++ ) {
//        var row = document.createElement('tr');
//        row.onmouseover = function() {
//            this.className += ' kd-highlight';
//        };
//        row.onmouseout = function() {
//            this.className = this.className.replace(/(?:^|\s)kd-highlight(?!\S)/,'');
//        };
//        if ( i % 2 == 0 ) {
//            row.setAttribute('class', 'kd-row kd-odd');
//        } else {
//            row.setAttribute('class', 'kd-row kd-even');
//        }
//        var j=0;
//        for ( var field in this.fields ) {
//            if ( this.fields.hasOwnProperty(field) ) {
//                var cell = document.createElement('td');
//                cell.onmouseover = function() {
//                    this.className += ' kd-highlight';
//                };
//                cell.onmouseout = function() {
//                    this.className = this.className.replace(/(?:^|\s)kd-highlight(?!\S)/,'');
//                };
//                cell.setAttribute('class', 'kd-cell');
//                var text = document.createTextNode(this.tableData[i][j]);
//                cell.appendChild(text);
//                this.cellCallback(this, cell, this.tableData[i], i, this.tableData[i][j], j);
//                row.appendChild(cell);    
//                j++;
//            }
//        }
//        this.rowCallback(this, row, this.tableData[i], i);
//        tbody.appendChild(row);
//    }
//    table.appendChild(tbody);
//    this.tableCallback(this, table);
//    if ( this.container.hasChildNodes() ) {
//        while ( this.container.childNodes.length >= 1 ) {
//            this.container.removeChild( this.container.firstChild );
//        }
//    }
//    this.container.appendChild(table);
//}