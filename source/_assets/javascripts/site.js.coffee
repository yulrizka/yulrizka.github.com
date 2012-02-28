pageView = (pane) ->
  container = $('#container')
  button = $('#icon-panel')
  if !pane? or pane == "none"
    container.removeClass 'sidebar-left sidebar-right'
    container.addClass 'sidebar-none'
    button.removeClass 'icon-left-panel icon-right-panel'
    button.addClass 'icon-no-panel'
  else if pane == "left"
    container.removeClass 'sidebar-right sidebar-none'
    container.addClass 'sidebar-left'
    button.removeClass 'icon-no-panel icon-right-panel'
    button.addClass 'icon-left-panel'
  else if pane == "right"
    container.removeClass 'sidebar-left sidebar-none'
    container.addClass 'sidebar-right'
    button.removeClass 'icon-no-panel icon-left-panel'
    button.addClass 'icon-right-panel'
    
$ ->
  $('.content').css('min-height', $('#sidebar-wrapper').height() + 40)
  $('#sidebar-wrapper').show();
  $("a[rel='popover']").popover()
  $('a#sidebar-left-link').click -> pageView 'left'
  $('a#sidebar-none-link').click -> pageView 'none'
  $('a#sidebar-right-link').click -> pageView 'right'
  