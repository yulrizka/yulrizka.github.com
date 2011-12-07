$ ->
  for tag in $('.highlight pre code')
    tagObj = $(tag)
    if tagObj.hasClass('ruby')
      tagObj.parents('.highlight').addClass('ruby')