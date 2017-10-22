
// Node browser js to save

$(document).on('click', '.zebra-save-data', function (event) {
    var formdata = $('.zebra-field-data-form').serializeArray();


    var ajaxRequest = $.ajax({
        type: "POST",
        url: "/zebraapi/nodeservice/savenode",
        data: formdata,
        success(data)
        {
            alert("Data Saved");
        //    LoadNodeBrowser(ZebraEditor_currentnode.element.attr("data-nodeid"));
        }
    });
    ajaxRequest.done(function (data, textStatus, jqXHR) {
        
    });
    event.preventDefault();
});

