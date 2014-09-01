$ ->

  $('select').selectize({
    addPrecedence: true
    })

  $('[data-behavior=user-select]').change ->
    bg_image = $('[data-images]').data('images')[$(@).val()]
    if bg_image
      $(@).parents('[data-behavior=user-select-box]').css('background-image', "url(#{bg_image})")
      $(@).parents('[data-behavior=user-select-box]').addClass('has-image')

  $('body').on 'click', '[data-behavior=user-select-box]', ->
    selectize = $(@).find('select').data('selectize')
    selectize.open()
