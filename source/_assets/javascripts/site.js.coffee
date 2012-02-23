pageView = (pane) ->
  container = $('#container')
  if !pane? or pane == "none"
    container.removeClass 'sidebar-left sidebar-right'
    container.addClass 'sidebar-none'
  else if pane == "left"
    container.removeClass 'sidebar-right sidebar-none'
    container.addClass 'sidebar-left'
  else if pane == "right"
    container.removeClass 'sidebar-left sidebar-none'
    container.addClass 'sidebar-right'
  
$ ->
  $('.content').css('min-height', $('#sidebar-wrapper').height() + 40)
  $('#sidebar-wrapper').show();
  $("a[rel='popover']").popover()
  $('a#sidebar-left-link').click -> pageView 'left'
  $('a#sidebar-none-link').click -> pageView 'none'
  $('a#sidebar-right-link').click -> pageView 'right'
  