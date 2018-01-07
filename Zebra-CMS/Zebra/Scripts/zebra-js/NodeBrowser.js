
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

//js to add new locale to a node

$(document).on('change','.zebra-language-selector',function () {
    var languageid = this.value;
    var nodeid = $(this).attr("data-nodeid");
    LoadNodeBrowser(nodeid, null, null, null, languageid);
});

$(document).on("click", ".zebra-add-locale", function () {
    var sel = $(".zebra-language-selector");
    var nodeid = $(sel).attr("data-nodeid");
    var languageid = $(sel).val();
    var info = { nodeid: nodeid, languageid: languageid };
    $.ajax({
        type: "POST",
        url: "/zebraapi/nodeservice/RegisterLocaleForNode",
        cache: false,
        dataType: "json",
        data: JSON.stringify(info),
        async: false,
        success: function (json) {
            LoadNodeBrowser(nodeid, null, null, null, languageid);
        }
    });

});
