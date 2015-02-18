$ ->
  $('.remove-post').on 'click', (event) ->
    event.preventDefault()
    $this = $(this)

    $.ajax
      url: $this.attr('href')
      dataType: 'json'
      type: 'DELETE'

      success: ->
        $this.closest('.post').remove()
        decrease_posts_number()

  decrease_posts_number = ->
    $friends_number = $('#posts-number')
    $friends_number.text(parseInt($friends_number.text()) - 1)

  $('.like').on 'click', (event) ->
    $this = $(this)

    $.ajax
      url: $this.attr('href')
      dataType: 'json'
      data: { likable_type: 'Post' }
      type: $this.data('method')

      success: ->
        $this.toggleClass('like-pressed')
        if $this.data('method') == 'post'
          $this.data('method', 'delete')
          increase_likes_number($this)
        else
          $this.data('method', 'post')
          decrease_likes_number($this)

    false

  decrease_likes_number = ($like_link) ->
    $likes_number = $like_link.parent().find('#likes-number')
    $likes_number.text(parseInt($likes_number.text()) - 1)

  increase_likes_number = ($like_link) ->
    $likes_number = $like_link.parent().find('#likes-number')
    $likes_number.text(parseInt($likes_number.text()) + 1)
