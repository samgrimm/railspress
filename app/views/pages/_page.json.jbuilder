json.extract! page, :id, :website_id, :title, :content, :created_at, :updated_at
json.url page_url(page, format: :json)
