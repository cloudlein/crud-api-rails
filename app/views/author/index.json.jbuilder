json.data do 
  json.array! @author, partial: 'author/author', as: :author
end

json.partial! 'shared/pagination_meta', pagy: @pagy