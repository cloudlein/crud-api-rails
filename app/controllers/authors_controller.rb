class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    authors = Author.all
    render json: authors.map { |author| serialize_author(author) }, status: :ok
  end

  def show
    author = Author.find(params[:id])
    render json: serialize_author(author), status: :ok
  end

  def create
    author = Author.create!(param_author)
    render json: serialize_author(author), status: :created
  end

  def update
    author = Author.find(params[:id])
    author.update!(param_author)
    render json: serialize_author(author), status: :ok
  end

  private

  def serialize_author(author)
    {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      pen_name: author.pen_name,
      birth_date: author.birth_date,
      bio: author.bio,
      nationality: author.nationality,
      created_at: author.created_at,
      updated_at: author.updated_at
    }
  end

  def param_author
    params.permit(
      :first_name,
      :last_name,
      :pen_name,
      :birth_date,
      :bio,
      :nationality,
    )
  end

  def render_not_found_response
    render json: { error: "Book not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
