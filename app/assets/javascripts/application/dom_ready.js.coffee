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
  if $("#games").length
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
  if $("#crawls").length
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

  if $("#history").length
    rankings = $("#history").data('rankings')
    quotes   = $("#history").data('quotes')

    $("#history").highcharts
      title:
        text: "Spiel Historie"
      chart:
        plotBackgroundColor: null
        plotBorderWidth: 0
        plotShadow: false
        alignTicks: true
      tooltip:
        shared: true
        crosshairs: [true,false]
        style:
          fontSize: '14px'
          padding: '10px'
      xAxis:
        title:
          text: "Spiele"
        tickLength: 0
        labels:
          enabled: false
      yAxis: [
        { title: { text: "Ranking" }, format: '{value+1}', reversed: true, allowDecimals: false, tickInterval: 1 }
        { title: { text: "Quote" }, opposite: true }
      ]
      series: [
        { name: 'Ranking', data: rankings, yAxis: 0 }
        { name: 'Quote', data: quotes, yAxis: 1 }
      ]
