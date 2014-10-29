$ ->
  if $('#pages_kpis').length
    $('.ct-chart').each ->
      values = $(@).data('values')
      values = [values] unless $(@).data('multiple')
      labels = $(@).data('labels')
      data = {
        labels: labels,
        series: values
      }
      new Chartist.Line(@, data)
