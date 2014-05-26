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
      $('#meta-type-misc').val(initialValue)
    return

  setVisibilityOfCategoryInput = ->
    if $('#select_note_category').val() isnt 'other'
      $('#meta-type-misc').addClass('hide')
    else
      $('#meta-type-misc').removeClass('hide')

  updateCategory = ->
    newCategory = $('#select_note_category').val()
    if newCategory isnt 'other'
      $('#note_category').val(newCategory)
    else
      $('#note_category').val($('#meta-type-misc').val())

  # Triggers
  $('#select_note_category').change ->
    setVisibilityOfCategoryInput()
    updateCategory()

  $('#meta-type-misc').bind 'keyup', ->
    updateCategory()

  # Init
  initializeCategory()
  setVisibilityOfCategoryInput()
  return