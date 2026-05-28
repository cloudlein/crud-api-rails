json.data do
  json.array! @users, partial: 'users/user', as: :user
end

json.partial! "shared/pagination_meta", pagy: @pagy