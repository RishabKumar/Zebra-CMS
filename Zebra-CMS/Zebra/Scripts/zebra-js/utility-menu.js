console.log("Loading Utility Menu js");
$(document).on('click', '.fieldbuilder-addfields-btn', function () {
    debugger;
    var template = [];
    var templateid = {};
    templateid["templateid"] = $(ZebraEditor_currentnode.element.parentElement).attr("data-nodeid");
    template.push(templateid);
    var query = "fullyqualifiedname=Zebra.Utilities.UtilityProcessor.FieldBuilderUtility,Zebra&method=RenderFieldBuilder&data=" + JSON.stringify(template);
    $.get("./RenderUtility?" + query, function (data) {
        $("body").append(data);
        $('body').append("<div class='black-overlay'></div>");
    });
});