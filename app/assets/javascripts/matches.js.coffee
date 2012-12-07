# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".team_members select").change ->
    value = $(@).val()
    $(".team_members select").find("option[value='#{value}']").attr('disabled','disabled')
    $(@).find("option[value='#{value}']").removeAttr('disabled')
