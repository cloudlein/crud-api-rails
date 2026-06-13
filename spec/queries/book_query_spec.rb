# frozen_string_literal: true
require 'rails_helper'
RSpec.describe BookQuery do
  let!(:author) { create(:author) }
  let!(:book1) { create(:book, title: 'Ruby Basic', author: author, created_at: 2.days.ago) }
  let!(:book2) { create(:book, title: 'Advanced Rails', author: author, created_at: 1.day.ago) }

  describe '#call' do
    it 'filters by title' do
      params = {title: 'Rub'}
      results = BookQuery.new(params).call
      expect(results).to include(book1)
      expect(results).not_to include(book2)
    end

    it 'sort by title desc' do
      params = { sort_by: 'title', sort_dir: 'desc' }
      results = BookQuery.new(params).call
      expect(results.first).to eq(book1)
    end

    it 'filters by authors_id' do
      other_book = create(:book)
      params = { author_id: author.id }
      results = BookQuery.new(params).call
      expect(results).to include(book1, book2)
      expect(results).not_to include(other_book)
    end
  end
end