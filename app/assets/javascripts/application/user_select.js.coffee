$ ->

  $('[data-styling=custom-select]').selectize
    addPrecedence: true

  $('[data-behavior=user-select]').change ->
    bg_image = $('[data-images]').data('images')[$(@).val()] || "/assets/default_user.png"
    if bg_image
      $(@).parents('[data-behavior=user-select-box]').css('background-image', "url(#{bg_image})")
      $(@).parents('[data-behavior=user-select-box]').addClass('has-image')

  $('body').on 'click', '[data-behavior=user-select-box]', ->
    selectize = $(@).find('select').data('selectize')
    if selectize
      selectize.open()

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
