require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should have_secure_password }
    
    it 'defaults to user role' do
      user = build(:user)
      expect(user.role).to eq('user')
    end

    it 'allows valid roles' do
      expect(build(:user, role: 'admin')).to be_valid
      expect(build(:user, role: 'user')).to be_valid
    end
  end
end
