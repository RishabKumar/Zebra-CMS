
// Node browser js to save

$(document).on('click', '.zebra-save-data', function (event) {
    var formdata = $('.zebra-field-data-form').serializeArray();
    var ajaxRequest = $.ajax({
        type: "POST",
        url: "/zebraapi/nodeservice/savenode",
        data: formdata,
        success(data)
        {
            if (ZebraEditor_currentnode.element != null)
            {
                LoadNodeBrowser($(ZebraEditor_currentnode.element.parentElement).attr('data-nodeid'), 'test', 'test', 'test');
            }
        }
    });
    ajaxRequest.done(function (data, textStatus, jqXHR) {
        
    });
    event.preventDefault();
});

