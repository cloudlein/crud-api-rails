# frozen_string_literal: true

json.id    book.id
json.title book.title

json.author do
  json.id   book.author&.id
  json.name "#{book.author&.first_name} #{book.author&.last_name}".strip
end

json.genres book.genres do |genre|
  json.id   genre.id
  json.name genre.name
end

json.created_at book.created_at
json.updated_at book.updated_at
