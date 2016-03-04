'use strict'

# path to loading gif file
gifElement = '<img src="/images/default.gif" alt="Loading..." title="Loading..." />'
# element that will be placed if post have no comments
noCommentsMessage = '<p class="text-center">No comments have been added yet.</p>'

# prepares wall
prepareWall = ->
  # remove comment form if it exists
  removeNewForm()
  #reveal post messages if hidden
  $( '.panel' ).show()

# removes form for comments create/update
removeNewForm = ->
  $( '#new_comment' ).remove()

# return id of closest .panel element
getId = (el) ->
  el.closest('.panel').attr('id')

# set focus on input field
focusOnInput = ->
  $( '#message_body' ).focus()
  return

# page is ready for manipulation
$( document ).ready ->
  # hide notices and warnings with timeout
  setTimeout ->
    $('.alert').slideUp()
  , 5000
  
  # Appends comments to posted message
  # when the post header is clicked
  $( document ).on 'click', '.glyphicon', (e) ->
    $( this ).toggleClass('glyphicon-menu-down glyphicon-menu-right')
    removeNewForm()

    # toggle list of comments
    target = $( this ).closest('.panel').find('.panel-footer')

    if $( target ).is(':parent')
      target.empty()
    else
      target.append(gifElement)
      post_id = getId($( this ))

      # make an ajax call passing post id
      $.ajax
        type: 'GET'
        url: '/'
        data: id: post_id
        dataType: 'script'
        success: (res)->
          target.find('img').first().remove()
          if not $( target ).is(':parent')
            $( target ).append(noCommentsMessage)
          return
    return

  # Adds commenting form
  $(document.body).on('click', '.btn.btn-success.pull-right', (e) ->
    e.stopPropagation()

    prepareWall()
    # id of parent post
    post_id = getId($( this ))

    $.ajax
      type: 'GET'
      url: '/messages/new'
      data: id: post_id
      dataType: 'script'
      success: ->
        focusOnInput()
  )

  # Adds edit form for messages
  $(document.body).on('click', '#edit', (e) ->
    e.stopPropagation()

    prepareWall()
    # id of post
    post_id = getId($( this ))

    $.ajax
      type: 'GET'
      url: '/messages/' + post_id + '/edit'
      dataType: 'script'
      success: ->
        focusOnInput()
  )

  # trigger cancel button press => hide comment form
  $( document.body ).on('click', '#cancel', (e) ->
    prepareWall()
  )

  # infinite scrolling feature
  if $( '#infinite-scrolling' ).size() > 0
    $( window ).on 'scroll', ->
      more_posts_url = $( '.pagination .next_page a' ).attr('href')
      if more_posts_url && $(window).scrollTop() > $( document ).height() - $( window ).height() - 80
        # add loading gif image
        $('.pagination').html(gifElement)
        $.getScript more_posts_url
      return
    return