require 'rails_helper'


RSpec.describe GenreQuery do
  let!(:genre1) {create(:genre, name: 'Horror')}
  let!(:genre2) {create(:genre, name: 'Comedy')}

  describe '#call' do
    it 'filters by name' do
      params = { name: 'horror'}
      results = GenreQuery.new(Genre.all, params).call
      expect(results).to include(genre1)
      expect(results).not_to include(genre2)
    end

    it 'return all when no params given ' do
      results = GenreQuery.new(Genre.all, {}).call
      expect(results.count).to eq(2)
    end
  end
end