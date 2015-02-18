$ ->
  $('.remove-friend').on 'click', (event) ->
    $this = $(this)

    $.ajax
      url: $this.attr('href')
      dataType: 'json'
      type: 'DELETE'

      success: ->
        $this.closest('.user-block').remove()
        decrease_friends_number()

    false

  decrease_friends_number = ->
    $friends_number = $('#friends-number')
    $friends_number.text(parseInt($friends_number.text()) - 1)
