$ ->
  $("[data-value]").click ->
    $user = $(@)
    $team = $(@).parents(".m-user-list")
    team_count = $team.data('count')
    $users = $("[data-value=#{$user.data('value')}]")
    if $user.hasClass('as-selected')
      $users.removeClass('as-disabled')
      $input = $team.find("select[data-player=#{team_count - 1}]")
      $shuffle_input = $("input[data-player=#{team_count - 1}]")
      $shuffle_input.val("")
      $user.removeClass('as-selected')
      $team.data('count', team_count - 1)
      $input.val('')

    else
      if $user.parent("[data-behaviour=shuffle_select]").length && team_count < 4
        $user.addClass('as-selected')
        $team.data('count', team_count + 1)
        $shuffle_input = $("input[data-player=#{team_count}]")
        $shuffle_input.val($user.data('value'))
      if team_count < 2
        $users.addClass('as-disabled')
        $user.removeClass('as-disabled')
        $input = $team.find("select[data-player=#{team_count}]")
        $user.addClass('as-selected')
        $team.data('count', team_count + 1)
        $input.val($user.data('value'))


