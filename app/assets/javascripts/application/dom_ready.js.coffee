$ ->
  $('.m-navigation-trigger').click ->
    if $('.m-navigation').css('display') == 'none'
      $('.m-navigation').slideDown()
    else
      $('.m-navigation').slideUp()

  $('[data-behavior=trigger-chat]').click ->
    $('#userlikeTab').trigger('click')


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
    quotas   = $("#history").data('quotas')
    lowestRank = $("#history").data('lowest-rank')

    $("#history").highcharts
      title:
        text: null
      chart:
        plotBackgroundColor: null
        plotBorderWidth: 0
        plotShadow: false
        alignTicks: true
      plotOptions:
        line:
          marker:
            enabled: false
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
        { title: null, format: '{value+1}', reversed: true, allowDecimals: false, tickInterval: 1, gridLineColor: '#f5f5f5', min: 1, max: lowestRank }
        { title: null, opposite: true, gridLineColor: '#f5f5f5' }
      ]
      series: [
        { name: 'Platzierung', data: rankings, yAxis: 0 }
        { name: 'Punkte', data: quotas, yAxis: 1 }
      ]
