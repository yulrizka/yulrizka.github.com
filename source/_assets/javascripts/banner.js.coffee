$ ->
  changeHeader = (i)->
    current = $('#banner li.active')
    to = $('#banner li').eq i
    console.log current
    console.log to
    
    if current.index() != to.index()

      $('.nav li').removeClass 'banner'
      $('.nav li').eq(i).addClass('banner')
      

      current.stop(true,true).fadeOut 'fast', ->        
        current.removeClass('active')
        to.fadeIn 'fast', ->
          to.addClass('active')
      console.log('change')
  
  $('.nav li').mouseenter ->
    changeHeader $(this).index()