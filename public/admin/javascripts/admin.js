$(document).ready(function(){
  $(".show_description").click(function(){
    text = $(this).text();
    text == "show" ? $(this).text("hide") : $(this).text("show");

    var form = $(this).data('div-id');
    $("#"+form).toggle();
    return false;
  })
})
