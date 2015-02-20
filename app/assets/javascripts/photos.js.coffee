$ ->
  $('#photo-uploader-submit').on 'click', (event) ->
    $('#photo-uploader-input').click()
    false

  $('#photo-uploader-input').on 'change', (event) ->
    $(this).parents('form').submit()

