class BooksController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  def index
    if params[:author_id]
      author = Author.find(params[:author_id])
      books  = author.books
    elsif params[:genre_id]
      genre = Genre.find(params[:genre_id])
      books  = genre.books
    else
      books = Book.all
    end

    render json: books.map { |book| serialize_book(book) }, status: :ok
  end

  def show
    book = Book.find(params[:id])
    render json: serialize_book(book), status: :ok
  end

  def create
    book = Book.create!(book_params)
    render json: serialize_book(book), status: :created
  end

  def update
    book = Book.find(params[:id])
    book.update!(book_params)
    render json: serialize_book(book), status: :ok
  end

  def destroy
    Book.find(params[:id]).destroy
    head :no_content
  end

  private

  def serialize_book(book)
    {
      id: book.id,
      title: book.title,
      author: {
        id: book.author&.id,
        name: "#{book.author&.first_name} #{book.author&.last_name}".strip
      },
      genres: book.genres.map { |genre|
        {
          id: genre.id,
          name: genre.name
        }
      },
      created_at: book.created_at,
      updated_at: book.updated_at
    }
  end
  def book_params
    params.permit(:title, :author_id, genre_ids: [])
  end

  def render_not_found_response
    render json: { error: "Book not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end



end
