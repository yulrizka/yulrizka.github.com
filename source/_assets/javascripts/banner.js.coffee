$ ->
  banner = $('#carousel-banner')
  banner.carousel interval: 100000
  banner.carousel 'pause'
  $('.nav-link .nav li').mouseenter ->
    banner.carousel $(this).index()
    banner.carousel 'pause'