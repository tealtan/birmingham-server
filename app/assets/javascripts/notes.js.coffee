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

  setVisibilityOfCategoryInput = ->
    if $('#select_note_category').val() isnt 'other'
      $('#note_category').addClass('hide')
    else
      $('#note_category').removeClass('hide')

  updateCategory = ->
    newCategory = $('#select_note_category').val()
    $('#note_category').val(newCategory) unless newCategory is 'other'

  # Triggers
  $('#select_note_category').change ->
    setVisibilityOfCategoryInput()
    updateCategory()
    if $('#select_note_category').val() is 'other'
      $('#note_category').val('')

  # Init
  initializeCategory()
  setVisibilityOfCategoryInput()
  return