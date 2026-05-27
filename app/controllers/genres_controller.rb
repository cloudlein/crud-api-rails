# frozen_string_literal: true

class GenresController < ApplicationController
  include Paginatable

  # GET /genres
  # GET /genres?page=1&limit=10
  def index
    collection = Genre.all

    @pagy, @genres = paginate(collection)
  end

  # GET /genres/:id
  def show
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  def create
    @genre = Genre.new(genre_params)

    unless @genre.valid?
      return render json: { errors: @genre.errors.full_messages },
                    status: :unprocessable_entity
    end

    @genre.save!
    render :create, status: :created
  end

  # PATCH/PUT /genres/:id
  def update
    @genre = Genre.find(params[:id])

    unless @genre.update(genre_params)
      return render json: { errors: @genre.errors.full_messages },
                    status: :unprocessable_entity
    end

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
