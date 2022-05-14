$(document).on('click', '.pay-fine', function(event){
  event.preventDefault();

  var FineId = $(this).parent().attr('id');
  var FineData = $("#"+FineId).data('finedata');
  var BankBalance = $(".bank-app-account-balance").data('balance');

  $.post('https://qb-phone/PayFine', JSON.stringify({
      amount: FineData.amount,
      society: FineData.society,
      fineId: FineData.id
  }), function(CanPay){
      if (CanPay) {
          $("#"+FineId).animate({
              left: 50+"vh",
          }, 300, function(){
              setTimeout(function(){
                  $("#"+FineId).remove();
              }, 100);
          });
          QB.Phone.Notifications.Add("fas fa-university", "Pank", "Sa maksid &#36;"+FineData.amount+"!", "#badc58", 1500);
          var amountData = $(".bank-app-account-balance").data('balance');
          var NewAmount = (amountData - FineData.amount).toFixed();
          $("#bank-transfer-amount").val(NewAmount);
          $(".bank-app-account-balance").data('balance', NewAmount);
      } else {
          QB.Phone.Notifications.Add("fas fa-university", "Pank", "Sul ei ole kontol piisavalt raha!", "#badc58", 1500);
      }
  });
});

QB.Phone.Functions.LoadFines = function(fines) {
  if (fines !== null) {
    $(".fines-app-fines-list").html("");

      $.each(fines, function(i, fine){
        const timer = fine.timer
        let timeleft;
        
        if (timer <= 10080 && timer > 8640) {
          timeleft = '6 Päeva';
        } else if (timer <= 8640 && timer > 7200) {
          timeleft = '5 Päeva';
        } else if (timer <= 7200 && timer > 5760) {
          timeleft = '4 Päeva';
        } else if (timer <= 5760 && timer > 4320) {
          timeleft = '3 Päeva';
        } else if (timer <= 4320 && timer > 2880) {
          timeleft = '2 Päeva';
        } else if (timer <= 2880 && timer > 1440) {
          timeleft = '1 Päev';
        } else if (timer <= 1440) {
          timeleft = '0 Päeva';
        }

        var Elem = '<div class="fines-app-fine" id="fineid-'+i+'"> <div class="fines-app-fine-title">'+fine.reason+'</div> <div class="fines-app-fine-amount">$'+fine.amount+'</div> <div class="fines-app-fine-pay pay-fine">Maksa</div> <div class="fines-app-fine-timeleft">Aega Jäänud: '+timeleft+'</div> </div>';
        $(".fines-app-fines-list").append(Elem);
        $("#fineid-"+i).data('finedata', fine);
    });
  }
}

$(document).ready(function() {
  $('[data-toggle="popover"]').popover({
    placement: 'top',
    trigger: 'hover'
  });
});