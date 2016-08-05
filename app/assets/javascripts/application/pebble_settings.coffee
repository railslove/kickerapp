$ ->

  url = window.location.href
  unless url.indexOf("#") is -1
    hash = url.substring(url.indexOf("#") + 1)
    options = JSON.parse decodeURIComponent(hash)
    $('#league').val options.league_slug
    $('#token').val options.token

  $('#pebble_settings_form').submit (e) ->
    options =
      league_slug: $('#league').val()
      league_name: $('#league option:selected').text()
      receive_notifications: if $('#receive_notifications').prop('checked') then '1' else '0'
    document.location = "pebblejs://close##{ encodeURIComponent JSON.stringify(options) }"
    return false

  $('#cancel').click (e) ->
    e.preventDefault()
    document.location = 'pebblejs://close'


  $('#freckle_settings_form').submit (e) ->
    options =
      token: $('#token').val()
    document.location = "pebblejs://close##{ encodeURIComponent JSON.stringify(options) }"
    return false
