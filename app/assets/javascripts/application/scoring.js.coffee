$ ->
  $('[data-behavior=mobile-scoring-close]').on 'tap', ->
    $('.as-live, .as-mobile-end, .as-mobile-visible').hide()
    $('[data-behavior=init-mobile-scoring], [data-behavior=init-end-scoring]').show()
    $('.input-rows input[type=text]').attr('disabled', 'disabled')
    $('.input-rows').removeClass('as-mobile-visible')
    false

  $('[data-behavior=init-mobile-scoring]').on 'tap', ->
    $('.as-live').show()
    $('.m-team-select').addClass('with-overlay')
    $('[data-behavior=init-end-scoring]').hide()
    $('.input-rows input').attr('disabled', 'disabled')
    false

  $('[data-behavior=init-end-scoring]').on 'tap', ->
    $('.as-mobile-end').show()
    $('[data-behavior=init-end-scoring]').hide()
    $('.input-rows').addClass('as-mobile-visible')
    $('.input-rows').show()
    $('.input-rows input[disabled=disabled]').removeAttr('disabled')
    false

  $('[data-behavior=counter]').on 'tap', ->
    input = $("[data-behavior=#{$(@).data('target')}] input")
    count = parseInt(input.val())
    input.val(count + 1)

  $('[data-behavior=minus-counter]').on 'tap', ->
    input = $("[data-behavior=#{$(@).data('target')}] input")
    count = parseInt(input.val())
    if count > 0
      input.val(count - 1)
    false
