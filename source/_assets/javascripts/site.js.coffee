$ ->
  $('.content').css('min-height', $('#sidebar-wrapper').height() + 40)
  $('#sidebar-wrapper').show();
  $("a[rel='popover']").popover()
  
  