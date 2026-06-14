require 'rails_helper'

RSpec.describe "Genres", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let!(:genre) { create(:genre) }
  let(:headers) { auth_headers(user) }

  describe "GET /genres" do
    it "returns a list of genres" do
      get "/genres", headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('data')
    end
  end

  describe "GET /genres/:id" do
    it "returns the genre" do
      get "/genres/#{genre.id}", headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(genre.id)
    end
  end

  describe "POST /genres" do
    let(:valid_params) { { name: 'Science Fiction', slug: 'sci-fi' } }

    it "creates a genre" do
      expect {
        post "/genres", params: valid_params, headers: headers, as: :json
      }.to change(Genre, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /genres/:genre_id/books" do
    let!(:books) { create_list(:book, 2) }
    
    before do
      books.each { |b| b.genres << genre }
    end

    it "returns books belonging to the genre" do
      get "/genres/#{genre.id}/books", headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['data'].length).to eq(2)
    end
  end

  describe "DELETE /genres/:id" do
    context "as admin" do
      it "deletes the genre" do
        expect {
          delete "/genres/#{genre.id}", headers: auth_headers(admin), as: :json
        }.to change(Genre, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
