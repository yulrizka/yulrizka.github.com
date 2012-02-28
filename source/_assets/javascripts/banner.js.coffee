$ ->
  banner = $('#carousel-banner')
  banner.carousel interval: 3600*24
  banner.carousel 'pause'
  $('.nav-link .nav li').mouseenter ->
    banner.carousel $(this).index()
    banner.carousel 'pause'