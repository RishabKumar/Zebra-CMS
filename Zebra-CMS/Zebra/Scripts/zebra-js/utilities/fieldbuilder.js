﻿$(document).on('click', '.close-button', function (e) {
    $(".zebra-fieldbuilder-container").remove();
    $('.black-overlay').remove();
});

$(document).on('click', '.remove-field-button', function (e) {
    var fielddiv = $(e.target).parent();
    $(fielddiv).remove();
});

$(document).on('click', '.save-field-button', function (e) {
    var typesarr = $('.fields-fieldbuilder .field select');
    var namesarr = $('.fields-fieldbuilder .field input');
    formdata = [];
    fieldsdata = [];
    template = {}
    template["templatenodeid"] = $(ZebraEditor_currentnode.element).attr("data-nodeid");
    fieldsdata.push(template);
    for (i = 0; i < namesarr.length; i++) {
        field = {}
        field["name"] = namesarr[i].value;
        field["id"] = namesarr[i].id;
        field["typeid"] = typesarr[i].value;
        fieldsdata.push(field);
    }
    fullyqualifiedname = {};
    fullyqualifiedname["fullyqualifiedname"] = "Zebra.Utilities.UtilityProcessor.FieldBuilderUtility,Zebra";
    methodname = {};
    methodname["methodname"] = "Process";
    formdata.push(fullyqualifiedname);
    formdata.push(methodname);
    formdata.push(fieldsdata);


    console.log(formdata);

    $.ajax({
        type: "POST",
        url: "/zebraapi/UtilityService/InvokeMethod",
        data: { '': JSON.stringify(formdata) },
        dataType: "json",
        async: true,
        success: function (json) {
            alert("Field Created ");
            console.log(json);
        },
        error: function (e) {
            console.log(e);
        }
    });
    $(".zebra-fieldbuilder-container").remove();
    $('.black-overlay').remove();

});

$(document).on('click', '.add-field-button', function (e) {
    $('.fields-fieldbuilder').append($('.field-sample').clone().attr('class', 'field'));
});
$(document).on('mouseup', function (e) {
    var fields = $('.zebra-fieldbuilder .field');

    for (var i = 0; i < fields.length; i++) {
        if ($(fields[i]).find('input').val() == '' && $(event.target.parentElement).attr('class') != 'field') {
            $(fields[i]).remove();
        }
    }
});