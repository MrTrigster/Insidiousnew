var queue = false;

function AddTask(data) {
  if (data !== null) {

    let text = 'Alusta'
    let disabled = ''
    let color = ''
    if (data.started === true) {
      text = 'Juba Pooleli'
      disabled = 'disabled'
      color = '#202730'
    }

    $(".boost-list").append(`
      <div class="boost" data-id="${data.id}">
        <div class="boost-header">
          <div class="boost-class">
            <div class="boost-class-letter">${data.class}</div>
          </div>
        </div>
        <div class="boost-info">
          <div class="boost-car">${data.name}</div>
          <div class="boost-price">Buy In: ${data.price} INC</div>
        </div>
        <div class="boost-buttons">
          <button class="boost-start" style="background: ${color}" data-task="start" data-id=${data.id} ${disabled} data-price=${data.price}>${text}</button>
          <button class="boost-transfer" style="background: ${color}" data-task="transfer" data-id=${data.id} ${disabled}>Anna Mängijale</button>
          <button class="boost-decline" data-task="remove" data-id=${data.id}>Eemalda</button>
        </div>
      </div>
    `)
  }
}

function setLevel(level, exp) {
  let levelText = "D"
  let nextLevelText = "C"
  let expProgress = exp / 10

  if (level === 2) {
    levelText = "C"
    nextLevelText = "B"
    expProgress = exp / 20
  } else if (level === 3) {
    levelText = "B"
    nextLevelText = "A"
    expProgress = exp / 40
  } else if (level === 4) {
    levelText = "A"
    nextLevelText = "S"
    expProgress = exp / 80
  } else if (level === 5) {
    levelText = "S"
    nextLevelText = "S"
    expProgress = 100
  }

  $(".boosting-class").html(levelText);
  $(".boosting-next-class").html(nextLevelText);
  $(".boosting-progress").append(`<style>.boosting-progress:after{
    content: '';
    display: block;
    width: ${expProgress}%;
    height: 1vh;
    background: linear-gradient(90deg, rgba(154,14,44,1) 0%, rgba(220,20,60,1) 50%, rgba(254,25,74,1) 100%);
  }</style>`);
}

function close() {
  $(".boost-list").empty()
  $('.container').hide();
  $('.container').css({"display": "none"});
}



$(document).on('click', '.shutoff', function(event){
  event.preventDefault();

  $.post("https://qb-boosting/close", JSON.stringify({}));
  $(".boost-list").empty()
  $('.container').hide();
  $('.container').css({"display": "none"});
});

$(document).on('click', '.boost-start', function(event) {
  event.preventDefault();

  task = $(this).data('task')
  id = $(this).data('id')
  price = $(this).data('price')

  if (task === 'start') {
    $('.boosting-start-modal').attr('data-id', id);
    $('.boosting-start-modal').attr('price', price);

    $('.boosting-start-modal').show();
    $('.boosting-start-modal').css({'display': 'block'});
    // close()
    // $.post("https://qb-boosting/startBoost", JSON.stringify({
    //   id: id,
    //   price: price
    // }));
  }
});

$(document).on('click', '.boosting-start-close', function(event) {
  event.preventDefault();

  $('.boosting-start-modal').hide();
  $('.boosting-start-modal').css({'display': 'none'});
});

$(document).on('click', '.boosting-start-confirm-contract', function(event) {
  event.preventDefault();

  var id = $(this).parent().parent().data('id');
  var price = $(this).parent().parent().attr('price');

  $('.boosting-start-modal').hide();
  $('.boosting-start-modal').css({'display': 'none'});

  close()
  $.post("https://qb-boosting/startBoost", JSON.stringify({
    id: id,
    price: price
  }));
});

$(document).on('click', '.boosting-start-confirm-vin', function(event) {
  event.preventDefault();

  var id = $(this).parent().parent().data('id');
  var price = $(this).parent().parent().attr('price');

  $('.boosting-start-modal').hide();
  $('.boosting-start-modal').css({'display': 'none'});

  close()
  $.post("https://qb-boosting/startVin", JSON.stringify({
    id: id,
    price: price
  }));
});

$(document).on('click', '.boost-decline', function(event){
  event.preventDefault();

  task = $(this).data('task')
  id = $(this).data('id')
  if (task === null) {
    return
  }

  if (task === 'remove') {
    $.post("https://qb-boosting/remove", JSON.stringify({
      id: id,
    }));
  }
});

$(document).on('click', '.boost-transfer', function(event){
  event.preventDefault();

  task = $(this).data('task')
  id = $(this).data('id')
  if (task === null) {
    return
  }

  if (task === 'transfer') {
    $('.boosting-transfer-modal').prop('id', id);

    $('.boosting-transfer-modal').show();
    $('.boosting-transfer-modal').css({'display': 'block'});
  }
});

$(document).on('click', '.boosting-transfer-confirm', function(event){
  event.preventDefault();

  var boostid = $(this).parent().parent().attr('id');

  var inputValue = $('#transfer-input').val();
  if (!inputValue) {
    return
  } else {
    $.post("https://qb-boosting/transferBoostContract", JSON.stringify({
      boostId: boostid,
      playerId: inputValue,
    }));
    $('.boosting-transfer-modal').hide();
    $('.boosting-transfer-modal').css({'display': 'none'});
  }
});

$(document).on('click', '.boosting-transfer-close', function(event){
  event.preventDefault();

  $('.boosting-transfer-modal').hide();
  $('.boosting-transfer-modal').css({'display': 'none'});
});

$(document).on('click', '.boosting-queue-btn', function(event){
  event.preventDefault();

  if (queue === false) {
    $('.boosting-queue-btn').html("Lõpeta Otsimine");
    queue = true;
  } else if (queue === true) {
    $('.boosting-queue-btn').html("Alusta Otsimist");
    queue = false;
  };
  console.log(queue);
  $.post("https://qb-boosting/toggleQueue", JSON.stringify({
      toggleQueue: queue,
  }));
});

$(document).keyup(function(event){
  if (event.key === "Escape"){
    $.post("https://qb-boosting/close", JSON.stringify({}));
    $(".boost-list").empty()
    $('.container').hide();
    $('.container').css({"display": "none"});
  }
});

$(document).ready(function(){
  window.addEventListener("message", function(event){
    var data = event.data;

    if (data.action == "getLevel") {
      setLevel(data.level, data.experience);
    }

    if (data.action == "open") {
      if (data.toggle) {
        $('.container').show();
        $('.container').css({"display": "block"});
      } else {
        $('.container').hide();
        $('.container').css({"display": "none"});
      }
      if (data.searching == true) {
        $('.boosting-queue-btn').html("Lõpeta Otsimine");
        queue = true;
      } else {
        $('.boosting-queue-btn').html("Alusta Otsimist");
        queue = false;
      }
    }

    if (data.action == "delete") {
      $(`.boost[data-id="${data.boostid}"]`).remove();
    }

    if (data.add == "true") {
      AddTask(data.data)
    }
  })
})