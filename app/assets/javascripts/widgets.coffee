ready = undefined
set_positions = undefined

set_positions = ->
  $('.sorty-card').each (i) ->
    $(this).attr 'data-pos', i + 1
    return
  return

ready = ->
  set_positions()
  $('.sortable').sortable()
  $('.sortable').sortable().bind 'sortupdate', (e, ui) ->
    currentPathname = window.location.pathname
    sortPathname = currentPathname + '/widgets/sort'
    updated_order = []
    set_positions()
    $('.sorty-card').each (i) ->
      updated_order.push
        id: $(this).data('id')
        position: i + 1
      return
    $.ajax
      type: 'PUT'
      url: sortPathname
      data: order: updated_order
    return
  return

$(document).ready ready
