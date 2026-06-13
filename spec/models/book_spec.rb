require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(1) }
  end

  describe 'associations' do
    it { should belong_to(:author) }
    it { should have_many(:book_genres).dependent(:destroy) }
    it { should have_many(:genres).through(:book_genres) }
  end
end
