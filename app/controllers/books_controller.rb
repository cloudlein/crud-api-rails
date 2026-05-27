# frozen_string_literal: true

class BooksController < ApplicationController
  include Paginatable

  # GET /books
  # GET /books?author_id=1&page=1&limit=10
  # GET /books?genre_id=2&page=2
  def index
    collection =
      if params[:author_id]
        Author.find(params[:author_id]).books
      elsif params[:genre_id]
        Genre.find(params[:genre_id]).books
      else
        Book.all
      end

    @pagy, @books = paginate(collection)
  end

  # GET /books/:id
  def show
    @book = Book.find(params[:id])
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.save!
    render :create, status: :created
  end

  # PATCH/PUT /books/:id
  def update
    @book = Book.find(params[:id])
    @book.update!(book_params)
    render :update, status: :ok
  end

  # DELETE /books/:id
  def destroy
    Book.find(params[:id]).destroy
    head :no_content
  end

  private

  def book_params
    params.permit(:title, :author_id, genre_ids: [])
  end

end
