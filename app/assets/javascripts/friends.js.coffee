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

  $('.friends-panel').find('a').on 'click', (event) ->
    event.preventDefault()
    $this = $(this)

    $this.parents('.friends-panel').find('dd').removeClass('active')
    $this.parents('dd').addClass('active')

  $('#all-friends').on 'click', (event) ->
    $('.find-friends').hide()
    $('.pending-friends').hide()
    $('.all-friends').show()

  $('#pending-friends').on 'click', (event) ->
    $('.all-friends').hide()
    $('.find-friends').hide()
    $('.pending-friends').show()

  $('#find-friends').on 'click', (event) ->
    $('.all-friends').hide()
    $('.pending-friends').hide()
    $('.find-friends').show()
