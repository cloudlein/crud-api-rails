# frozen_string_literal: true

class AuthorsController < ApplicationController
  include Paginatable

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
    @author = Author.new(author_params)
    @author.save!
    render :create, status: :created
  end

  # PATCH/PUT /authors/:id
  def update
    @author = Author.find(params[:id])
    @author.update!(author_params)
    render :update, status: :ok
  end

  # DELETE /authors/:id
  def destroy
    Author.find(params[:id]).destroy
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
