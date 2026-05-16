class BooksController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionController::RecordInvalid, with: :render_unprocessable_entity_response

  private

  def render_not_found_response
    render json: { error: "Book not found" }, status: :not_found
  end

  def render_unprocessable_entity_response
    render json: {errors: invalid.record}
  end
end
