# frozen_string_literal: true

class GenresController < ApplicationController
  include Paginatable
  before_action :require_admin, only: [:destroy]
  
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
    service = Genres::CreateService.new(genre_params)
    if service.call
      @genre = service.genre
      render :create, status: :created
    else
      render json: { errors: service.genre.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres/:id
  def update
    service = Genres::UpdateService.new(params[:id], genre_params)
    if service.call
      @genre = service.genre
      render :update, status: :ok
    else
      render json: { errors: service.genre.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /genres/:id
  def destroy
    Genres::DestroyService.new(params[:id]).call
    head :no_content
  end

  private

  def genre_params
    params.permit(:name, :slug)
  end

end
