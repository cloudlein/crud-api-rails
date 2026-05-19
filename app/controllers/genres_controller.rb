class GenresController < ApplicationController
  def index
    genres = Genre.all
    render json: genres.map {
      |genre| serialize_genre(genre)
    }
  end

  def show
    genre = genre.find(params[:id])
    render json: serialize_genre(genre)
  end

  def create
    genre = Genre.create!(param_genres)
    render json: serialize_genre(genre), status: :created
  end

  def update
    genre = Genre.find(params[:id])
    genre.update!(param_genres)
    render json: serialize_genre(genre), status: :ok
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    render json: serialize_genre(genre), status: :ok
  end

  private

  def serialize_genre(genre)
    {
      id: genre.id,
      name: genre.name,
      slug: genre.slug,
      created_at: genre.created_at,
      updated_at: genre.updated_at
    }
  end


  def param_genres
    params.permit(
      :name,
      :slug
    )
  end


  def render_not_found_response
    render json: { error: "Book not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end


