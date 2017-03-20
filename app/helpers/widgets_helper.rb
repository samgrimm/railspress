module WidgetsHelper

  def content(widget)
    if widget.type == 'Image'
      image_tag(widget.content, width: '100%')
    else
      widget.content
    end
  end
end
