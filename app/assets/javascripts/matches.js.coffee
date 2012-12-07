# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".team_members select").change ->
    value = $(@).val()
    $(".team_members select").find("option[value='#{value}']").attr('disabled','disabled')
    $(@).find("option[value='#{value}']").removeAttr('disabled')

  $(".user_selector .picture_selector").click ->
    $team = $(@).closest(".team_members")
    $pic = $(@)
    player_count = $team.data("member-count")
    if $pic.hasClass("active")
      $pic.removeClass('active')
      $(".picture_selector[data-id=#{$pic.data('id')}]").removeClass("blocked")
      $team.data("member-count",player_count - 1)
      $select = $team.find("select")
      $select.each ->
        $(@).val('') if $pic.data('id') == parseInt($(@).val())
    else if player_count < 2
      $pic.addClass('active')
      $(".picture_selector:not(.active)[data-id=#{$pic.data('id')}]").addClass("blocked")
      new_count = player_count + 1
      $team.data("member-count",new_count)
      $team.find("select[data-member-id=#{new_count}]").val($pic.data('id'))
