var activeJobData = null;
var activeModalData = null;

$(document).on('click', '.jobs-app-job-active', function(event){
  event.preventDefault();

  var JobId = $(this).parent().attr('id');
  var JobData = $("#"+JobId).data('jobdata');

  $.post('https://qb-phone/ToggleActiveJob', JSON.stringify({
    playerjob: JobData.job,
    playergrade: JobData.grade,
    jobId: JobData.id
  }));
  QB.Phone.Notifications.Add("fas fa-clipboard-list", "Töökohad", "Valitud töökoht aktiivseks seatud!", "#1a8cff", 3000);
});

QB.Phone.Functions.LoadJobs = function(jobs) {
  if (jobs !== null) {
    $(".jobs-app-jobs-list").html("");

      $.each(jobs, function(i, job){
        if (job.menu == 1) {
          var Elem = '<div class="jobs-app-job" id="jobid-'+job.id+'"> <div class="jobs-app-job-title">'+job.joblabel+'</div> <div class="jobs-app-job-rank-label">'+job.gradelabel+'</div> <div class="jobs-app-job-buttons"><div class="jobs-app-job-workers">Töötajad</div><div class="jobs-app-job-hire">Palka</div></div> <div class="jobs-app-job-active">Vali</div> </div>';
          $(".jobs-app-jobs-list").append(Elem);
          $("#jobid-"+job.id).data('jobdata', job);
        } else {
          var Elem = '<div class="jobs-app-job" id="jobid-'+job.id+'"> <div class="jobs-app-job-title">'+job.joblabel+'</div> <div class="jobs-app-job-rank-label">'+job.gradelabel+'</div> <div class="jobs-app-job-active">Vali</div> </div>';
          $(".jobs-app-jobs-list").append(Elem);
          $("#jobid-"+job.id).data('jobdata', job);
        }
    });
  }
};

QB.Phone.Functions.LoadCurrentJob = function(currentjob, currentduty) {
  var dutyText = ''
  if (currentjob !== null) {
    $(".jobs-header").html('<div class="jobs-header-text">MINU TÖÖKOHAD</div>');
    if (currentduty === true) {
      dutyText = 'On Duty'
    } else if (currentduty === false) {
      dutyText = 'Off Duty'
    }
    var Elem = '<div class="jobs-header-active">Aktiivne: '+currentjob+' / '+dutyText+'</div>';
    $(".jobs-header").append(Elem);
  }
};



$(document).on('click', '.jobs-hire-button', function(event){
  event.preventDefault();

  var PlayerId = $(this).parent().attr('id');
  var PlayerData = $("#"+PlayerId).data('jobplayerdata');

  $.post('https://qb-phone/HireSelectedPlayer', JSON.stringify({
    id: PlayerData.id,
    job: activeJobData.job
  }))
})



$(document).on('click', '.jobs-app-job-hire', function(event){
  event.preventDefault();

  var JobId = $(this).parent().parent().attr('id');
  var JobData = $("#"+JobId).data('jobdata');

  activeJobData = JobData;

  $.post('https://qb-phone/GetCurrentPlayers', JSON.stringify({}), function(Players){
    if (Players !== null) {
      $(".jobs-hire-list").html("");

      $.each(Players, function(i, player){
        var Elem = '<div class="jobs-hire-player" id="jobplayerid-'+player.id+'"> <div class="jobs-hire-player-name">'+player.firstname+' '+player.lastname+'</div> <div class="jobs-hire-button">Palka</div> </div>';
        $(".jobs-hire-list").append(Elem);
        $("#jobplayerid-"+player.id).data('jobplayerdata', player);
      });
    }
  });

  QB.Phone.Animations.TopSlideDown(".jobs-hire-tab", 450, 0);
})

$(document).on('click', '.jobs-hire-close-button', function(event){
  event.preventDefault();

  activeJobData = null;

  QB.Phone.Animations.TopSlideUp(".jobs-hire-tab", 450, -120);
  $(".jobs-hire-list").html("");
  $(".jobs-workers-modal-title").html("");
  $(".jobs-workers-tab-modal").css({"display": "none"});
})



$(document).on('click', '.jobs-workers-button', function(event){
  event.preventDefault();

  var WorkerId = $(this).parent().attr('id');
  var WorkerData = $("#"+WorkerId).data('jobworkerdata');

  $.post('https://qb-phone/FireSelectedPlayer', JSON.stringify({
    id: WorkerData.id,
    job: activeJobData.job
  }))
})

$(document).on('click', '.jobs-app-job-workers', function(event){
  event.preventDefault();

  var JobId = $(this).parent().parent().attr('id');
  var JobData = $("#"+JobId).data('jobdata');

  activeJobData = JobData;

  $.post('https://qb-phone/GetCurrentWorkers', JSON.stringify({
    job: JobData.job
  }), function(Workers){
    if (Workers !== null) {
      $(".jobs-workers-list").html("");

      $.each(Workers, function(i, worker){
        var Elem = '<div class="jobs-workers-player" id="jobworkerid-'+worker.id+'"> <div class="jobs-workers-player-name">'+worker.firstname+' '+worker.lastname+'</div> <div class="jobs-workers-player-rank">'+worker.gradelabel+'</div> <div class="jobs-workers-settings">Tegevused</div> <div class="jobs-workers-button">Vallanda</div> </div>';
        $(".jobs-workers-list").append(Elem);
        $("#jobworkerid-"+worker.id).data('jobworkerdata', worker);
      });
    }
  });

  QB.Phone.Animations.TopSlideDown(".jobs-workers-tab", 450, 0);
})

$(document).on('click', '.jobs-workers-close-button', function(event){
  event.preventDefault();

  activeJobData = null;
  activeModalData = null;

  QB.Phone.Animations.TopSlideUp(".jobs-workers-tab", 450, -120);
  $(".jobs-workers-list").html("");
  $(".jobs-workers-modal-title").html("");
  $(".jobs-workers-tab-modal").css({"display": "none"});
})



$(document).on('click', '.jobs-workers-settings', function(event){
  event.preventDefault();

  var WorkerId = $(this).parent().attr('id');
  var WorkerData = $("#"+WorkerId).data('jobworkerdata');

  activeModalData = WorkerData;

  $(".jobs-workers-modal-title").html("");
  var Name = ''+WorkerData.firstname+' '+WorkerData.lastname+'';
  $(".jobs-workers-modal-title").append(Name);

  $(".jobs-workers-tab-modal").css({"display": "block"});
})

$(document).on('click', '.jobs-workers-buttons-addmenu', function(event){
  event.preventDefault();

  $.post('https://qb-phone/AddWorkerMenu', JSON.stringify({
    job: activeJobData.job,
    id: activeModalData.id
  }));

  $(".jobs-workers-modal-title").html("");
  $(".jobs-workers-tab-modal").css({"display": "none"});

  activeModalData = null;
})

$(document).on('click', '.jobs-workers-buttons-takemenu', function(event){
  event.preventDefault();

  $.post('https://qb-phone/RemoveWorkerMenu', JSON.stringify({
    job: activeJobData.job,
    id: activeModalData.id
  }));

  $(".jobs-workers-modal-title").html("");
  $(".jobs-workers-tab-modal").css({"display": "none"});

  activeModalData = null;
})

$(document).on('click', '.jobs-workers-buttons-close', function(event){
  event.preventDefault();

  activeModalData = null;

  $(".jobs-workers-modal-title").html("");
  $(".jobs-workers-tab-modal").css({"display": "none"});
  $(".jobs-workers-grade-modal").css({"display": "none"});
})



$(document).on('click', '.jobs-workers-buttons-rank', function(event){
  event.preventDefault();

  $(".jobs-workers-grade-modal").css({"display": "block"});
})

$(document).on('click', '.jobs-workers-grade-close', function(event){
  event.preventDefault();

  $(".jobs-workers-grade-modal").css({"display": "none"});
})

$(document).on('click', '.jobs-workers-grade-confirm', function(event){
  event.preventDefault();

  var inputValue = $("#grade-input").val()
  if (!inputValue) {
    QB.Phone.Notifications.Add("fas fa-clipboard-list", "Töökohad", "Sa ei ole numbrit sisestanud!", "#1a8cff", 2500);
  } else {
    $.post("https://qb-phone/ChangeWorkerGrade", JSON.stringify({
      job: activeJobData.job,
      id: activeModalData.id,
      grade: inputValue
    }));
    $(".jobs-workers-grade-modal").css({"display": "none"});
  };
})