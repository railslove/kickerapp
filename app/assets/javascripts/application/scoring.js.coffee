$ ->
  $('[data-behavior=init-mobile-scoring]').on 'tap', ->
    $('[data-behavior=mobile-scoring]').show()
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
