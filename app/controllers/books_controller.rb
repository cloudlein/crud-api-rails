# frozen_string_literal: true

class BooksController < ApplicationController
  include Paginatable
  before_action :require_admin, only: [:destroy]

  # GET /books
  # GET /books?author_id=1&page=1&limit=10
  # GET /books?genre_id=2&page=2
  def index
    collection = BookQuery.new(params).call
    @pagy, @books = paginate(collection)
  end

  # GET /books/:id
  def show
    @book = Book.find(params[:id])
  end

  # POST /books
  def create
    service = Books::CreateService.new(book_params)
    service.call
    @book = service.book
    render :create, status: :created
  end

  # PATCH/PUT /books/:id
  def update
    service = Books::UpdateService.new(params[:id], book_params)
    service.call
    @book = service.book
    render :update, status: :ok
  end

  # DELETE /books/:id
  def destroy
    Books::DestroyService.new(params[:id]).call
    head :no_content
  end

  private

  def book_params
    params.permit(:title, :author_id, genre_ids: [])
  end

end
