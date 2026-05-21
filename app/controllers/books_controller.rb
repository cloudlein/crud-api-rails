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
    dto = BookCreationDTO.new(book_params)
    return render json: {errors: dto.errors}, status: :unprocessable_entity unless dto.valid

    book = BookCreationService.call(dto)
    render json: serialize_book(book), status: :created
  end

  def update
    dto = BookUpdateDTO.new(book_params.merge(id: params[:id]))

    if dto.valid?
      book = BookUpdateService.call(dto)
      render json: serialize_book(book), status: :ok
    else
      render json: {
        errors: dto.errors.full_messages
      }, status: :unprocessable_entity
    end

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
