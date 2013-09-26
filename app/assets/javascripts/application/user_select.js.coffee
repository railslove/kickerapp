$ ->
  $("[data-value]").click ->
    $user = $(@)
    $team = $(@).parents(".m-user-list")
    team_count = $team.data('count')
    $users = $("[data-value=#{$user.data('value')}]")

    if $user.hasClass('as-selected')
      $users.removeClass('as-disabled')
      $input = $team.find("select[data-player=#{team_count - 1}]")
      console.log "select[data-player=#{team_count}]"
      $user.removeClass('as-selected')
      $team.data('count', team_count - 1)
      $input.val('')
    else
      if team_count < 2
        $users.addClass('as-disabled')
        $user.removeClass('as-disabled')
        $input = $team.find("select[data-player=#{team_count}]")
        console.log "select[data-player=#{team_count}]"
        $user.addClass('as-selected')
        $team.data('count', team_count + 1)
        $input.val($user.data('value'))

