# frozen_string_literal: true

class GenresController < ApplicationController
  include Paginatable

  # GET /genres
  # GET /genres?name=action&sort_by=name&sort_dir=asc&page=1&limit=10
  def index
    collection = GenreQuery.new(Genre.all, params).call

    @pagy, @genres = paginate(collection)
  end

  # GET /genres/:id
  def show
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  def create
    @genre = Genre.new(genre_params)
    @genre.save!
    render :create, status: :created
  end

  # PATCH/PUT /genres/:id
  def update
    @genre = Genre.find(params[:id])
    @genre.update!(genre_params)
    render :update, status: :ok
  end

  # DELETE /genres/:id
  def destroy
    Genre.find(params[:id]).destroy
    head :no_content
  end

  private

  def genre_params
    params.permit(:name, :slug)
  end

end
