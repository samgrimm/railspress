class PagesChannel < ApplicationCable::Channel

  def subscribed
    stream_from "pages_#{params['page_id']}_channel"
  end

  def unsubscribed
  end

  def send_widget(data)
    page = Page.find(data['page_id'])
    page.widgets.create!(
              col_span: data['widget']['col_span'],
              title: data['widget']['title'],
              content: data['widget']['content'],
              type: data['widget']['type'])
  end
end
