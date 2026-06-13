# frozen_string_literal: true

class NotifyNewBookJob < ApplicationJob
  queue_as :default

  def perform(book_id)
    book = Book.find_by(id: book_id)
    return unless book

    Rails.logger.info "Async Task: Sent notification for new book: #{book.title}"
  end
end
