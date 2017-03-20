jQuery(document).on 'turbolinks:load', ->
  widgets = $('#widgets')
  if widgets.length > 0
    App.global_chat = App.cable.subscriptions.create {
      channel: "PagesChannel"
      page_id: widgets.data('page-id')
    },
    connected: ->
    disconnected: ->
    received: (data) ->
      widgets.append data['widget']
    send_widget: (widget, page_id) ->
      @perform 'send_widget',  widget: widget, page_id: page_id
  $('#new_widget').submit (e) ->
    $this = $(this)
    textarea = $this.find('#widget_content')
    title = $this.find('#widget_title')
    col_span = $this.find('#widget_col_span')
    if $.trim(textarea.val()).length > 1
      widget =
        content: textarea.val()
        title: title.val()
        col_span: col_span.val()
      App.global_chat.send_widget widget,
      widgets.data('page-id')
      textarea.val('')
      title.val('')
      col_span.val('')
    e.preventDefault()
    return false
