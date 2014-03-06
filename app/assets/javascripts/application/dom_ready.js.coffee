$ ->
  $('.m-navigation-trigger').click ->
    if $('.m-navigation').css('display') == 'none'
      $('.m-navigation').slideDown()
    else
      $('.m-navigation').slideUp()


  games = $("#stats").data('games')
  crawls = $("#stats").data('crawls')

  Highcharts.setOptions({
       colors: ['#5FAF3E', '#954142']
      });

  $("#games").highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: 0
      plotShadow: false

    title:
      text: "Spiele"
      align: "center"
      verticalAlign: "middle"
      y: 50

    plotOptions:
      pie:
        dataLabels:
          enabled: true
          distance: 0
          style:
            color: "black"

        startAngle: -90
        endAngle: 90
        center: [
          "50%"
          "75%"
        ]

    series: [
      type: "pie"
      name: "Spiele"
      innerSize: "40%"
      data: games
    ]
  $("#crawls").highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: 0
      plotShadow: false

    title:
      text: "Krabbeln"
      align: "center"
      verticalAlign: "middle"
      y: 50


    plotOptions:
      pie:
        dataLabels:
          enabled: true
          distance: 0
          style:
            color: "black"

        startAngle: -90
        endAngle: 90
        center: [
          "50%"
          "75%"
        ]

    series: [
      type: "pie"
      name: "Krabbeln"
      innerSize: "40%"
      data: crawls
    ]

