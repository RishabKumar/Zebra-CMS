$(document).on('click', '.zebra-inheritance-removetemplate-btn', function () {
    debugger;
    var selectedtemplate = $('.zebra-inheritance-templatelist select option:selected');
    $(selectedtemplate).remove();
});

function AddSelectedTemplate(node) {
    debugger;
    var nodeid = node.attr('data-nodeid');
    var tmp = $('.zebra-inheritance-sample option').clone();
    $(tmp).attr('value', nodeid);
    tmp.text($(node).select('p').text());
    var list = $('.zebra-inheritance-templatelist select');
    list.append(tmp);
}
$(document).on('click', '.zebra-inheritance-addtemplate-btn', function () {

    $('.zebra-inheritance-container').toggle();
    ShowModelTreePopup(null, null, null, null, function () { AddSelectedTemplate($(GetSelectedNodeInPopup())); $('.zebra-inheritance-container').toggle(); });
});

$(document).on('click', '.zebra-inheritance-savetemplate-btn', function (e) {
    debugger;
    var templatearr = $('.zebra-inheritance-templatelist select option');
    formdata = [];
    inheritancedata = [];
    currenttemplate = {};
    currenttemplate["nodeid"] = $('#currentnodeid').val();
    inheritancedata.push(currenttemplate);
    for (i = 0; i < templatearr.length; i++) {
        template = {}
        template["id"] = templatearr[i].value;
        template["name"] = templatearr[i].text;
        inheritancedata.push(template);
    }
    fullyqualifiedname = {};
    fullyqualifiedname["fullyqualifiedname"] = "Zebra.Utilities.UtilityProcessor.InheritanceUtility,Zebra";
    methodname = {};
    methodname["methodname"] = "Process";
    formdata.push(fullyqualifiedname);
    formdata.push(methodname);
    formdata.push(inheritancedata);
    console.log(formdata);

    $.ajax({
        type: "POST",
        url: "/zebraapi/UtilityService/InvokeMethod",
        data: { '': JSON.stringify(formdata) },
        dataType: "json",
        async: true,
        success: function (json) {
            alert("Saved");
            console.log(json);
        },
        error: function (e) {
            console.log(e);
        }
    });
    $(".zebra-inheritance-container").remove();
    $('.black-overlay').remove();
    if (ZebraEditor_currentnode.element != null) {
        LoadNodeBrowser($(ZebraEditor_currentnode.element.parentElement).attr('data-nodeid'), 'test', 'test', 'test');
    }
});

$(document).on('click', '.zebra-inheritance-canceltemplate-btn', function () {
    $(".zebra-inheritance-container").remove();
    $('.black-overlay').remove();
});

//--- Inheritance-Menu-js

$(document).on('click', '.inheritance-showdialog-btn', function () {
    debugger;
    var node = [];
    var nodeid = {};
    nodeid["nodeid"] = $(ZebraEditor_currentnode.element.parentElement).attr("data-nodeid");
    node.push(nodeid);
    var query = "fullyqualifiedname=Zebra.Utilities.UtilityProcessor.InheritanceUtility,Zebra&method=RenderInheritance&data=" + JSON.stringify(node);
    $.get("./RenderUtility?" + query, function (data) {
        $("body").append(data);
        $('body').append("<div class='black-overlay'></div>");
    });
});