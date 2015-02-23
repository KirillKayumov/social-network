$ ->
  $('.messages-panel').find('a').on 'click', (event) ->
    event.preventDefault()
    $this = $(this)

    $this.parents('.messages-panel').find('dd').removeClass('active')
    $this.parents('dd').addClass('active')

  $('#received-messages-link').on 'click', (event) ->
    $('#sent-messages-block').hide()
    $('#received-messages-block').show()

  $('#sent-messages-link').on 'click', (event) ->
    $('#received-messages-block').hide()
    $('#sent-messages-block').show()
