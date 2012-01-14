$ ->
  $('#social-icon a').popover()
  @sidebar = false
  $('a.brand').click ->
    sidebar =  $('.container > .row > .sidebar')
    content = $('.container > .row > .content')
    drop_pane = $('#drop-pane')
    if !@sidebar
      sidebar.show()
      content.addClass 'span11'
      drop_pane.slideDown 'slow'
    else
      drop_pane.slideUp 'slow', ->
        sidebar.hide()
        content.removeClass('span11')
    @sidebar = !@sidebar
    false