# frozen_string_literal: true
require 'rails_helper'
RSpec.describe AuthorQuery do
  let!(:author1) { create(:author, first_name: "Charles", last_name: "Green") }
  let!(:author2) { create(:author, first_name: "Alan", last_name: "Turing") }


  describe '#call' do
    it 'filters by name (partial match)' do
      params = { name: 'Charles'}
      results = AuthorQuery.new(Author.all, params).call
      expect(results).to include(author1)
      expect(results).not_to include(author2)
    end

    it 'sorts by first_name' do
      params = { sort_by: 'first_name' , sort_dir: 'asc'}
      results = AuthorQuery.new(Author.all, params).call
      expect(results.to_a).to eq([author2, author1])
    end
  end
end