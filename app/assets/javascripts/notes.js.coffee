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

  initializeCategory()
  return