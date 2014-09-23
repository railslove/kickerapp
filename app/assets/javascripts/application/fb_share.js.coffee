$ ->
  $('[data-behavior=fb-share-match]').click ->
    text = $(@).data('text')
    link = $(@).data('link')
    FB.login (->
      FB.api "/me/feed", "post",
        message: text,
        link: link
      return
    ),
      scope: "publish_actions"

  $('[data-behavior=fb-share-page]').click ->
    link = $(@).data('link')
    caption = $(@).data('caption')
    FB.ui
      method: "feed"
      link: link
      caption: caption
    , (response) ->
      console.log "Shared"
