$ ->
  $('.m-navigation-trigger').click ->
    if $('.m-navigation').css('display') == 'none'
      $('.m-navigation').slideDown()
    else
      $('.m-navigation').slideUp()

  # if $("#games").length
  #   ctx = $("#games").get(0).getContext("2d")
  #   data = $("#games").data('games')
  #   console.log data
  #   myNewChart = new Chart(ctx).Doughnut(data,{segmentShowStroke : true})
  #   console.log myNewChart
