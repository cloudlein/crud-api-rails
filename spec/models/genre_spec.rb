require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject { build(:genre) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:book_genres).dependent(:destroy) }
    it { should have_many(:books).through(:book_genres) }
  end
end
