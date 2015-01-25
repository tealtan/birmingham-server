# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->

  initializeCategory = ->
    initialValue = $('#note_category').val()
    matchOption = $('#select_note_category option[value="'+initialValue+'"]')
    if matchOption.length > 0
      matchOption.prop('selected', true)
    else
      $('#select_note_category option[value="other"]').prop('selected', true)
    return

  createFieldsOfCategory = (category) ->
    categoryFormNames =
      'text':       []
      'question':   ['note[question]', 'note[answered]']
      'quote':      ['note[quote]', 'note[quote_source]']
      'place':      ['note[place]', 'note[place_latitude]', 'note[place_longitude]']
      'url':        ['note[url]', 'note[url_tags]']
      'file':       ['note[file]']
      'book':       ['note[book_title]', 'note[book_author]', 'note[book_pubdate]']
      'movie':      ['note[movie_title]', 'note[movie_director]', 'note[movie_releasedate]']
      'tv-show':    ['note[tvshow_title]', 'note[tvshow_creator]', 'note[tvshow_startdate]', 'note[tvshow_season]', 'note[tvshow_episode]']
      'music':      ['note[music_artist]', 'note[music_album]', 'note[music_track]', 'note[music_releasedate]']
      'recipe':     ['note[recipe]', 'note[recipe_source]', 'note[recipe_ingredients]', 'note[recipe_steps]']
      'image-note': ['note[imagenote]', 'note[imagenote_x]', 'note[imagenote_y]']
      'other':      []

    # 1. Look up category in categoryFormNames, get array
    formArray = categoryFormNames[category]

    # 2. Loop through the array and generate text field string
    formLength = formArray.length
    formString = ''
    i = 0
    while i < formLength
      formName = formArray[i]
      formID = formName.replace('[', '_').replace(']', '')

      # Set formLabel
      switch formID
        when 'note_answered'
          formLabel = 'answered?'
        when 'note_book_pubdate'
          formLabel = 'published on'
        when 'note_movie_releasedate', 'note_music_releasedate'
          formLabel = 'released on'
        when 'note_tvshow_startdate'
          formLabel = 'started on'
        when 'note_quote_source', 'note_recipe_source'
          formLabel = 'by'
        else
          formLabel = formName
                        .replace(/(^.*\[|\].*$)/g,'')
                        .replace(/.+?(?=_)/g,'')
                        .replace('_', ' ')

      switch formName
        when 'note[recipe_ingredients]', 'note[recipe_steps]' # Add exceptions for text fields
          formString += '<textarea id="' + formID + '" name="' + formName + '" placeholder="' + formLabel + '"></textarea> <br>'
        when 'note[file]' # Add exceptions for file fields
          formString += '<label for="attachment">File</label>
                         <input id="note_attachment" name="note[attachment]" type="file">'
        else
          formString += '<label for="' + formID + '">' + formLabel + '</label>'
          formString += '<input id="' + formID + '" name="' + formName + '" type="text"> <br>'
      i++

    # 3. InnerHTML on the .insert element
    $('.meta-fieldinsert').html(formString);
    return

  setVisibilityOfCategoryInput = ->
    if $('#select_note_category').val() isnt 'other'
      $('#note_category').addClass('hide')
    else
      $('#note_category').removeClass('hide')

  updateCategory = ->
    newCategory = $('#select_note_category').val()
    $('#note_category').val(newCategory) unless newCategory is 'other'

  # setVisibilityofMetadataFields = ->
  #   selectedCategory = $('#select_note_category').val()
  #   metadataSelector = '.meta-' + selectedCategory + '-fields'
  #   $('.meta-fieldgroup').addClass('hide')
  #   $(metadataSelector).removeClass('hide')
  #   return

  # Triggers
  # $('#select_note_category').change ->
  #   setVisibilityOfCategoryInput()
  #   updateCategory()
  #   setVisibilityofMetadataFields()
  #   if $('#select_note_category').val() is 'other'
  #     $('#note_category').val('')

  $('#select_note_category').change ->
    setVisibilityOfCategoryInput()
    updateCategory()
    createFieldsOfCategory($('#select_note_category').val())
    if $('#select_note_category').val() is 'other'
      $('#note_category').val('')

  # Init
  initializeCategory()
  setVisibilityOfCategoryInput()
  # setVisibilityofMetadataFields()
  return