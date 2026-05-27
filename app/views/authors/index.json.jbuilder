# frozen_string_literal: true

json.data do
  json.array! @authors, partial: "authors/author", as: :author
end

json.partial! "shared/pagination_meta", pagy: @pagy
