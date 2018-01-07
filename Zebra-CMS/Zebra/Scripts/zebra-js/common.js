$(document).ajaxStart(function () {
    $(document.body).css({ 'cursor': 'wait' });
    $('.zebra-mouse-loader').show();
    
});

$(document).ajaxComplete(function (event, xhr, settings) {
    $(document.body).css({ 'cursor': 'default' });
    $('.zebra-mouse-loader').hide();
   
});

function showLoader()
{
    $(document.body).css({ 'cursor': 'wait' });
    $('.zebra-mouse-loader').show();
    $('body').append("<div class='black-overlay'></div>");
}

function hideLoader()
{
    $(document.body).css({ 'cursor': 'default' });
    $('.zebra-mouse-loader').hide();
    $('.black-overlay').remove();
}


 
    var zebra_loader = document.getElementById("zebra-mouse-loader");
    $(zebra_loader).hide();
    var ctx = zebra_loader.getContext("2d");
    var zebra_loadervari = .1;
    setInterval(function () {

        ctx.clearRect(0, 0, 500, 500);
        ctx.beginPath();
        ctx.arc(50, 50, 45, zebra_loadervari, 1.6 * Math.PI + zebra_loadervari);
        ctx.stroke();

        zebra_loadervari = zebra_loadervari + .05;

    }, 8);
 