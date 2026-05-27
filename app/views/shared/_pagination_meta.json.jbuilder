json.meta do
  json.current_page pagy.page
  json.total_pages  pagy.pages
  json.total_count  pagy.count
  json.next_page    pagy.next
  json.prev_page    pagy.previous
  json.limit        pagy.limit
end
