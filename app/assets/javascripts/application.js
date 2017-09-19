//= require jquery
//= require jquery_ujs
//= require ajax_setup
//= require ajax_modal
//= require bootstrap
//= require flash_message
//= require visibility_map
//= require modal
//= require select2
//= require select2_init
//= require bootstrap-datepicker

// Navbar Brand setting
$(function() {
  $("#main-nav div div.navbar-header a").on("click", function(e) {
    if($(this).hasClass("active")){
      $(this).removeClass("active");
      $("#wrap .row.sidebar").removeClass("active");
      $(".row#main-content").removeClass("active");
      $("#studyLists").removeClass("active");
      $("#report").removeClass("active");
    }else{
      $(this).addClass("active");
      $("#wrap .row.sidebar").addClass("active");
      $(".row#main-content").addClass("active");
      $("#studyLists").addClass("active");
      $("#report").addClass("active");
    }
  });
});

// Collapse tasks in a study setting - will also collapse the corresponding gantt charts
$(function() {
  var study_id;
  $("a.collapsingTask").on("click", function(e) {
    study_id = "#" + $(this).attr('aria-controls');
    if($('.add-task-link' + study_id).hasClass("active")){
      $('.task-link' + study_id).slideToggle(300);
      $('.add-task-link' + study_id).slideToggle(300);
      
    }else{
      $('.task-link' + study_id).slideToggle(300);
      $('.add-task-link' + study_id).slideToggle(300);
      
    }
  });

});

// Ajax submission for assigning staff to a task
$(document).on("click", "#setStaff", function(e) {
  e.preventDefault();
  var staff_id = $("#staffNameOption").val();
  var role_id = $("#roleOption").val();
  var task_id = $(this).data('task');

  if(staff_id != null && role_id != null && task_id != null){
    $.ajax({
      type:"POST",
      url:"/line_staffs?grade=" + role_id + "&staff_id=" + staff_id + "&task_id=" + task_id,
      dataType:"script",
      data: {
        staff_id: staff_id,
        role_id: role_id,
        task_id: task_id
      },
      success:function(result){
        $("#result span.info").text("Successfully assigned staff.");
        $(".alert-wrapper").addClass("active");
        setTimeout( function() { 
          $(".alert-wrapper").removeClass("active");
        }, 2000);
      }
    })
  }else {
    alert("Please select staff and role to be assigned.");
  }

});

$(document).on("click", "#new_user .update-study", function(e) {
  if($("#user_grade").val() == "" || $("#new_user input#new_staff").val() == ""){
    alert("username or grade can't be empty");
    e.preventDefault();
  }
});

$(document).on("click", "form#new_staff .update-study", function(e) {
  if($("#staff_name").val() == ""){
    alert("User CiCS account can't be empty");
    e.preventDefault();
  }else if($("#staff_grade").val() == ""){
    alert("Grade can't be empty");
    e.preventDefault();
  }else if($("#staff_staffgivenname").val() == ""){
    alert("Staff name can't be empty");
    e.preventDefault();
  }
});

// Ajax submission for deleting staff from a task
$(document).on("click", "#delete-staff", function(e) {
  e.preventDefault();
  var staff_id = $(this).data('staff');
  var task_id = $(this).data('task');

  $.ajax({
    type:"DELETE",
    url:"/line_staffs/" + staff_id,
    dataType:"script",
    data: {
      staff_id: staff_id,
      task_id: task_id
    },
    success:function(result){
      $("#result span.info").text("Successfully deleted staff.");
      $(".alert-wrapper").addClass("active");
      setTimeout( function() { 
        $(".alert-wrapper").removeClass("active");
      }, 2000);
    }
  })
});

$(document).on('change','#time_management_chart_year',function(){
  alert($(this).val());
  // $(this).parents('form').submit();
});

// Datepicker setting
$(document).on("focus", "[data-behavior~='datepicker']", function(e) {
  $(this).datepicker({"format": "dd/mm/yyyy", "weekStart": 1, "autoclose": true})
});
