require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

  describe "POST /auth/login" do
    context "with valid credentials" do
      it "returns a success response and a token" do
        post "/auth/login", params: { email: user.email, password: 'password123' }, as: :json
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
        expect(JSON.parse(response.body)['user']['email']).to eq(user.email)
      end
    end

    context "with invalid credentials" do
      it "returns an unauthorized response" do
        post "/auth/login", params: { email: user.email, password: 'wrongpassword' }, as: :json
        
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid credentials')
      end
    end
  end

  describe "POST /auth/register" do
    let(:valid_params) do
      {
        name: 'New User',
        email: 'newuser@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        role: 'user'
      }
    end

    context "with valid params" do
      it "creates a new user and returns a token" do
        expect {
          post "/auth/register", params: valid_params, as: :json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post "/auth/register", params: valid_params.merge(email: ''), as: :json
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end

  describe "Protected Endpoints" do
    it "returns 401 without token" do
      get "/books", as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 403 for insufficient role (non-admin deleting)" do
      user = create(:user, role: 'user')
      book = create(:book)
      
      delete "/books/#{book.id}", headers: auth_headers(user), as: :json
      
      expect(response).to have_http_status(:forbidden)
    end
  end
end
