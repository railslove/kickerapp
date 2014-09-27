$ ->
  $('[data-behavior=mobile-scoring-close]').on 'tap', ->
    $('.as-live, .as-mobile-end, .as-mobile-visible').hide()
    $('[data-behavior=init-mobile-scoring], [data-behavior=init-end-scoring]').show()
    $('.input-rows input[type=text]').attr('disabled', 'disabled')
    $('.input-rows').removeClass('as-mobile-visible')
    true

  $('[data-behavior=init-mobile-scoring]').on 'tap', ->
    $('.as-live').show()
    $('.m-team-select').addClass('with-overlay')
    $('[data-behavior=init-end-scoring]').hide()
    $('.input-rows input').attr('disabled', 'disabled')
    $('[data-behavior=disable-live]').attr('disabled', 'disabled')
    $('[data-behavior=disable-end]').removeAttr('disabled')
    true

  $('[data-behavior=init-end-scoring]').on 'tap', ->
    $('.as-mobile-end').show()
    $('[data-behavior=init-end-scoring]').hide()
    $('.input-rows').addClass('as-mobile-visible')
    $('.input-rows').show()
    $('[data-behavior=disable-live]').removeAttr('disabled')
    $('[data-behavior=disable-end]').attr('disabled', 'disabled')
    true

  $('[data-behavior=counter]').on 'tap', ->
    input = $("[data-behavior=#{$(@).data('target')}] input")
    count = parseInt(input.val())
    input.val(count + 1)

  $('[data-behavior=minus-counter]').on 'tap', ->
    input = $("[data-behavior=#{$(@).data('target')}] input")
    count = parseInt(input.val())
    if count > 0
      input.val(count - 1)
    true
