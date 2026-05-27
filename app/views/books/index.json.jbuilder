json.data do
  json.array! @books, partial: "books/book", as: :book
end

json.partial! 'shared/pagination_meta', pagy: @pagy