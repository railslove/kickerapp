$ ->

  url = window.location.href
  unless url.indexOf("#") is -1
    hash = url.substring(url.indexOf("#") + 1)
    options = JSON.parse decodeURIComponent(hash)
    $('#league').val options.league

  $('#pebble_settings_form').submit (e) ->
    options =
      league: $('#league').val()
    document.location = "pebblejs://close##{ encodeURIComponent JSON.stringify(options) }"
    return false

  $('#cancel').click (e) ->
    e.preventDefault()
    document.location = 'pebblejs://close'
