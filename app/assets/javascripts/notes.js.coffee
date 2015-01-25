# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->

  initializeCategory = ->
    initialValue = $('#note_category').val()
    matchOption = $('#select_note_category option[value="'+initialValue+'"]')
    if matchOption.length > 0
      matchOption.prop 'selected', true
    else
      $('#select_note_category option[value="other"]').prop 'selected', true
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

      # Set formID        e.g. note[book_title] to note_book_title
      formID = formName.replace('[', '_').replace(']', '')

      # Set formLabel     e.g. note[book_title] to title
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
                          <div id="note_attachment_container">
                            <span id="note_attachment_button">
                              <input id="note_attachment" name="note[attachment]" type="file">
                              <a href="#">Add file from your computer</a>
                            </span>
                            or <a id="note_attachment_useLink" href="#">use a URL</a>
                          </div>'
        else
          formString += '<label for="' + formID + '">' + formLabel + '</label>'
          formString += '<input id="' + formID + '" name="' + formName + '" type="text"> <br>'
      i++

    # 3. InnerHTML on the .insert element
    $(".meta-fieldinsert").html formString
    return

  setVisibilityOfCategoryInput = ->
    if $('#select_note_category').val() is 'other'
      $('#note_category').removeClass 'hide'
    else
      $('#note_category').addClass 'hide'
    return

  updateCategory = ->
    newCategory = $('#select_note_category').val()
    $('#note_category').val(newCategory) unless newCategory is 'other'
    return

  changeFileUploadToDirectURL = (element) ->
    $(element).replaceWith '<input id="note_attachment" name="note[attachment]" type="text" value="">'
    return

  $('#select_note_category').change ->
    setVisibilityOfCategoryInput()
    updateCategory()
    createFieldsOfCategory($('#select_note_category').val())

    # Special cases after category is changed
    if $('#select_note_category').val() is 'other'
      $('#note_category').val('')
    if $('#select_note_category').val() is 'file'
      $('#note_attachment_useLink').click ->
        changeFileUploadToDirectURL '#note_attachment_container'

    return

  # Init
  initializeCategory()
  setVisibilityOfCategoryInput()
  # setVisibilityofMetadataFields()
  return