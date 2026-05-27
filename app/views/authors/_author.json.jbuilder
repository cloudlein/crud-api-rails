# frozen_string_literal: true

json.id          author.id
json.first_name  author.first_name
json.last_name   author.last_name
json.full_name   "#{author.first_name} #{author.last_name}".strip
json.pen_name    author.pen_name
json.birth_date  author.birth_date
json.bio         author.bio
json.nationality author.nationality
json.created_at  author.created_at
json.updated_at  author.updated_at
