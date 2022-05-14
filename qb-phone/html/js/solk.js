$(document).on('click', '.solk-footer-start-btn', function(e){
    e.preventDefault();
    $.post('https://qb-phone/StartSolkDelivery', JSON.stringify({}));
});

$(document).on('click', '.solk-footer-cancel-btn', function(e){
    e.preventDefault();
    $.post("https://qb-phone/CancelSolkDelivery", JSON.stringify({}));
});