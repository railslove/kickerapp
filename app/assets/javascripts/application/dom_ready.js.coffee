$ ->
  $('.m-navigation-trigger').click ->
    if $('.m-navigation').css('display') == 'none'
      $('.m-navigation').slideDown()
    else
      $('.m-navigation').slideUp()
