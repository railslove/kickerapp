$ ->

  $('#pebble_settings_form').submit (e) ->
    options =
      league: $('#league').val()
    document.location = "pebblejs://close##{ encodeURIComponent JSON.stringify(options) }"
    return false

  $('#cancel').click (e) ->
    e.preventDefault()
    document.location = 'pebblejs://close'
