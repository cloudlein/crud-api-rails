# frozen_string_literal: true

class AuthorsController < ApplicationController
  include Paginatable
  before_action :require_admin, only: [:destroy]

  # GET /authors
  # GET /authors?page=1&limit=10
  def index
    collection = AuthorQuery.new(Author.all, params).call
    @pagy, @authors = paginate(collection)
  end

  # GET /authors/:id
  def show
    @author = Author.find(params[:id])
  end

  # POST /authors
  def create
    service = Authors::CreateService.new(author_params)
    if service.call
      @author = service.author
      render :create, status: :created
    else
      render json: { errors: service.author.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authors/:id
  def update
    service = Authors::UpdateService.new(params[:id], author_params)
    if service.call
      @author = service.author
      render :update, status: :ok
    else
      render json: { errors: service.author.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /authors/:id
  def destroy
    Authors::DestroyService.new(params[:id]).call
    head :no_content
  end

  private

  def author_params
    params.permit(
      :first_name,
      :last_name,
      :pen_name,
      :birth_date,
      :bio,
      :nationality
    )
  end
end
